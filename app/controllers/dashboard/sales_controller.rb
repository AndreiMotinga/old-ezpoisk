class Dashboard::SalesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_sale, only: [:edit, :update, :destroy]

  def new
    @sale = Sale.new state_id: current_user.state_id,
                     city_id: current_user.city_id,
                     phone: current_user.phone,
                     active: true,
                     email: current_user.email
  end

  def edit
  end

  def create
    @sale = current_user.sales.build(sale_params)

    if verify_recaptcha && @sale.save
      SlackNotifierJob.perform_async(@sale.id, "Sale")
      AdminMailerJob.perform_async(@sale.id, "Sale")
      GeocodeJob.perform_async(@sale.id, "Sale")
      redirect_to edit_dashboard_sale_path(@sale),
                  notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :new
    end
  end

  def update
    address_changed = address_changed?(@sale, sale_params)
    if @sale.update(sale_params)
      GeocodeJob.perform_async(@sale.id, "Sale") if address_changed
      redirect_to edit_dashboard_sale_path(@sale),
                  notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :edit
    end
  end

  def destroy
    @sale.destroy
    redirect_to dashboard_path, notice: I18n.t(:post_removed)
  end

  private

  def set_sale
    @sale = current_user.sales.find(params[:id])
  end

  def sale_params
    params.require(:sale).permit(:title,
                                 :price,
                                 :street,
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
