class Dashboard::ReCommercialsController < ApplicationController
  layout "dashboard"
  before_action :authenticate_user!
  before_action :set_re_commercial, only: [:show, :edit, :update, :destroy]

  def index
    @re_commercials = current_user.re_commercials
  end

  def new
    @re_commercial = ReCommercial.new
  end

  def show
  end

  def edit
  end

  def create
    @re_commercial = current_user.re_commercials.build(re_commercial_params)

    if @re_commercial.save
      redirect_to dashboard_re_commercial_path(@re_commercial),
                  notice: "Re commercial was successfully created."
    else
      render :new
    end
  end

  def update
    if @re_commercial.update(re_commercial_params)
      redirect_to dashboard_re_commercial_path(@re_commercial),
                  notice: "Re commercial was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @re_commercial.destroy
    redirect_to dashboard_re_commercials_path,
                notice: "Re commercial was successfully destroyed."
  end

  private

    def set_re_commercial
      @re_commercial = ReCommercial.find(params[:id])
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
