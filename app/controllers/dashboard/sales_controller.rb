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
    if @sale.update(sale_params)
      GeocodeJob.perform_async(@sale.id, "Sale") if address_changed?
      redirect_to edit_dashboard_sale_path(@sale),
                  notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :edit
    end
  end

  def destroy
    @sale.destroy
    redirect_to dashboard_sales_path,
                notice: I18n.t(:post_removed)
  end

  private

  # move to ApplicationController
  def address_changed?
    return true if @sale.state != sale_params[:state]
    return true if @sale.city != sale_params[:city]
  end

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

