class Dashboard::ReCommercialsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_re_commercial, only: [:edit, :update, :destroy]

  def index
    @re_commercials = current_user.re_commercials.page params[:page]
  end

  def new
    @re_commercial = ReCommercial.new state_id: current_user.state_id,
                                      city_id: current_user.city_id,
                                      active: true,
                                      phone: current_user.phone
  end

  def edit
  end

  def create
    @re_commercial = current_user.re_commercials.build(re_commercial_params)

    if verify_recaptcha &&  @re_commercial.save
      SlackNotifierJob.perform_async(@re_commercial.id, "ReCommercial")
      GeocodeJob.perform_async(@re_commercial.id, "ReCommercial")
      redirect_to edit_dashboard_re_commercial_path(@re_commercial),
                  notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :new
    end
  end

  def update
    address_changed = address_changed?(@re_commercial, re_commercial_params)
    if @re_commercial.update(re_commercial_params)
      GeocodeJob.perform_async(@re_commercial.id, "ReCommercial") if address_changed
      redirect_to edit_dashboard_re_commercial_path(@re_commercial),
                  notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :edit
    end
  end

  def destroy
    @re_commercial.destroy
    redirect_to dashboard_re_commercials_path,
                notice: I18n.t(:post_removed)
  end

  private

  def set_re_commercial
    @re_commercial = current_user.re_commercials.find(params[:id])
  end

  def re_commercial_params
    params.require(:re_commercial).permit(:street,
                                          :category,
                                          :post_type,
                                          :phone,
                                          :price,
                                          :baths,
                                          :space,
                                          :active,
                                          :description,
                                          :state_id,
                                          :city_id)
  end
end
