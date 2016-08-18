class Dashboard::ReCommercialsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_re_commercial, only: [:edit, :update, :destroy]

  def new
    @re_commercial = ReCommercial.new(state_id: current_user.state_id,
                                      city_id: current_user.city_id,
                                      active: true,
                                      phone: current_user.phone,
                                      email: current_user.email)
  end

  def edit
  end

  def create
    @re_commercial = current_user.re_commercials.build(re_commercial_params)
    if @re_commercial.save
      run_create_notifications
      redirect_to edit_dashboard_re_commercial_path(@re_commercial),
                  notice: I18n.t(:post_saved)
    else
      render :new, alert: I18n.t(:post_not_saved)
    end
  end

  def update
    changed = address_changed?(@re_commercial, re_commercial_params)
    if @re_commercial.update(re_commercial_params)
      GeocodeJob.perform_async(@re_commercial.id, "ReCommercial") if changed
      redirect_to update_redirect_path, notice: I18n.t(:post_saved)
    else
      render :edit, alert: I18n.t(:post_not_saved)
    end
  end

  def destroy
    @re_commercial.destroy
    redirect_to destroy_redirect_path, notice: I18n.t(:post_removed)
  end

  private

  def update_redirect_path
    if params[:token].present?
      edit_dashboard_re_commercial_path(@re_commercial, token: params[:token])
    else
      edit_dashboard_re_commercial_path(@re_commercial)
    end
  end

  def run_create_notifications
    SlackNotifierJob.perform_async(@re_commercial.id, "ReCommercial")
    GeocodeJob.perform_async(@re_commercial.id, "ReCommercial")
    @re_commercial.create_entry(user: current_user)
    create_subscription(@re_commercial)
  end

  def set_re_commercial
    if params[:token].present?
      @re_commercial = ReCommercial.find(params[:id])
      @re_commercial = nil unless @re_commercial.token == params[:token]
    else
      @re_commercial = current_user.re_commercials.find(params[:id])
    end
  end

  def re_commercial_params
    params.require(:re_commercial).permit(
      :street, :category, :post_type, :phone, :price, :baths, :space,
      :active, :description, :email, :state_id, :city_id
    )
  end
end
