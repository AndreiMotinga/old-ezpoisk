class RealEstate::ReCommercialsController < ApplicationController
  layout "real_estate"
  def index
    @re_commercials = ReCommercial.all.page params[:page]
  end

  def show
    @re_commercial = ReCommercial.find(params[:id])
  end
end
