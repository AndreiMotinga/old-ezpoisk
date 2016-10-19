class Dashboard::SalesController < ApplicationController
  before_action :set_sale, only: [:edit, :update, :destroy]

  def index
    @sales = current_user.sales.desc.includes(:state, :city).page(params[:page])
    respond_to do |format|
      format.html
      format.js do
        render partial: "shared/index", locals: { records: @sales }
      end
    end
  end

  def new
    @sale = Sale.new(state_id: current_user.try(:state_id),
                     city_id: current_user.try(:city_id),
                     phone: current_user.try(:phone),
                     active: true,
                     email: current_user.try(:new_email))
  end

  def edit
  end

  def create
    @sale = Sale.new(sale_params)
    @sale.user = current_user
    if @sale.save
      do_maintenance
      run_create_notifications
      redirect_on_create
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :new
    end
  end

  def update
    address_changed = address_changed?(@sale, sale_params)
    if @sale.update(sale_params)
      do_maintenance
      GeocodeJob.perform_async(@sale.id, "Sale") if address_changed
      run_update_notifications
      redirect_to update_redirect_path, notice: I18n.t(:post_saved)
    else
      render :edit
    end
  end

  def destroy
    @sale.destroy
    redirect_to destroy_redirect_path, notice: I18n.t(:post_removed)
  end

  private

  def redirect_on_create
    if @sale.user
      redirect_to(
        edit_dashboard_sale_path(@sale),
        notice: I18n.t(:post_created)
      )
    else
      redirect_to(
        edit_dashboard_sale_path(@sale, token: @sale.token),
        notice: I18n.t(:post_created_wr)
      )
    end
  end

  def update_redirect_path
    if params[:token].present?
      edit_dashboard_sale_path(@sale, token: params[:token])
    else
      edit_dashboard_sale_path(@sale)
    end

  end

  def run_update_notifications
    unless current_user.try(:team_member?)
      SlackNotifierJob.perform_async(@sale.id, "Sale", 'update')
    end
    @sale.entry.try(:touch)
  end

  def run_create_notifications
    SlackNotifierJob.perform_async(@sale.id, "Sale")
    GeocodeJob.perform_async(@sale.id, "Sale")
    FbExporterJob.perform_in(23.minutes, @sale.id, "Sale")
    VkExporterJob.perform_in(19.minutes, @sale.id, "Sale")
    @sale.create_entry(user: current_user)
  end

  def set_sale
    if current_user.try(:admin?)
      @sale = Sale.find(params[:id])
    elsif params[:token].present?
      @sale = Sale.find(params[:id])
      @sale = nil unless @sale.token == params[:token]
    else
      @sale = current_user.sales.find(params[:id])
    end
  end

  def sale_params
    params.require(:sale).permit(
      :title, :price, :street, :phone, :email, :text, :active,
      :state_id, :city_id, :logo, :category, :source, :vk, :fb, :post_type
    )
  end

  def destroy_redirect_path
    params[:token].present? ? root_path : dashboard_sales_path
  end

  def do_maintenance
    @sale.clear_phone!
  end
end
