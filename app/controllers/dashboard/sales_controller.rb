class Dashboard::SalesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_sale, only: [:edit, :update, :destroy]

  def new
    @sale = Sale.new(state_id: current_user.state_id,
                     city_id: current_user.city_id,
                     phone: current_user.phone,
                     active: true,
                     email: current_user.email)
  end

  def edit
  end

  def create
    @sale = current_user.sales.build(sale_params)
    if @sale.save
      run_jobs_and_notifications
      redirect_to edit_dashboard_sale_path(@sale), notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :new
    end
  end

  def update
    address_changed = address_changed?(@sale, sale_params)
    if @sale.update(sale_params)
      GeocodeJob.perform_async(@sale.id, "Sale") if address_changed
      @sale.entry.try(:touch)
      redirect_to edit_dashboard_sale_path(@sale), notice: I18n.t(:post_saved)
    else
      render :edit
    end
  end

  def destroy
    @sale.destroy
    redirect_to dashboard_path, notice: I18n.t(:post_removed)
  end

  private

  def run_jobs_and_notifications
    SlackNotifierJob.perform_async(@sale.id, "Sale")
    GeocodeJob.perform_async(@sale.id, "Sale")
    @sale.create_entry(user: current_user)
    create_subscription(@sale)
  end

  def set_sale
    @sale = current_user.sales.find(params[:id])
  end

  def sale_params
    params.require(:sale).permit(
      :title, :price, :street, :phone, :email, :description, :active,
      :state_id, :city_id, :logo, :category, :source
    )
  end
end
