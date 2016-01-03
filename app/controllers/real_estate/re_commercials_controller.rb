class RealEstate::ReCommercialsController < ApplicationController
  layout "real_estate"
  def index
    @re_commercials  = ReCommercial.filter(params.slice(:state_id,
                                                 :city_ids,
                                                 :post_type,
                                                 :space,
                                                 :min_price,
                                                 :max_price,
                                                 :sort))
    @re_commercials = @re_commercials.page(params[:page])
  end

  def show
    @re_commercial = ReCommercial.find(params[:id])
  end
end
