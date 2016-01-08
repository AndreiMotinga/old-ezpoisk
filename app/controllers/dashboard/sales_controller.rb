class Dashboard::SalesController < ApplicationController
  layout "dashboard"
  before_action :authenticate_user!
  before_action :set_sale, only: [:edit, :update, :destroy]

  def index
    @sales = current_user.sales
  end

  def new
    @sale = Sale.new
  end

  def edit
  end

  def create
    @sale = current_user.sales.build(sale_params)

    if @sale.save
      GeocodeJob.perform_async(@sale.id, "Sale")
      redirect_to edit_dashboard_sale_path(@sale),
                  notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :new
    end
  end

  def update
    return unless @sale.user == current_user
    if @sale.update(sale_params)
      if address_changed?(@sale, sale_params)
        GeocodeJob.perform_async(@sale.id, "Sale")
      end
      redirect_to edit_dashboard_sale_path(@sale),
                  notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :edit
    end
  end

  def destroy
    return unless @sale.user == current_user
    @sale.destroy
    redirect_to dashboard_sales_path,
                notice: I18n.t(:post_removed)
  end

  private

  def set_sale
    @sale = Sale.find(params[:id])
  end

  def sale_params
    params.require(:sale).permit(:title,
                                :phone,
                                :email,
                                :description,
                                :active,
                                :state_id,
                                :city_id,
                                :logo,
                                :category)
  end
end

