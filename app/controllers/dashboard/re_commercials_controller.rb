class Dashboard::ReCommercialsController < ApplicationController
  layout "dashboard"
  before_action :authenticate_user!
  before_action :set_re_commercial, only: [:edit, :update, :destroy]

  def index
    @re_commercials = current_user.re_commercials
  end

  def new
    @re_commercial = ReCommercial.new
  end

  def edit
  end

  def create
    @re_commercial = current_user.re_commercials.build(re_commercial_params)

    if @re_commercial.save
      GeocodeJob.perform_async(@re_commercial.id, "ReCommercial")
      redirect_to edit_dashboard_re_commercial_path(@re_commercial),
                  notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :new
    end
  end

  def update
    if @re_commercial.update(re_commercial_params)
      if address_changed?
        GeocodeJob.perform_async(@re_commercial.id, "ReCommercial")
      end
      redirect_to edit_dashboard_re_commercial_path(@re_commercial),
                  notice: I18n.t(:post_saved)
    else
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
      @re_commercial = ReCommercial.find(params[:id])
    end

  def address_changed?
    return true if @re_commercial.street != re_commercial_params[:street]
    return true if @re_commercial.state != re_commercial_params[:state]
    return true if @re_commercial.city != re_commercial_params[:city]
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
