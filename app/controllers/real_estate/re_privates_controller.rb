class RealEstate::RePrivatesController < ApplicationController
  layout "real_estate"

  def index
    @re_privates = RePrivate.filter(params.slice(:state_id,
                                                 :city_id,
                                                 :fee,
                                                 :duration,
                                                 :post_type,
                                                 :space,
                                                 :baths,
                                                 :rooms,
                                                 :min_price,
                                                 :max_price,
                                                 :sort))
    @total = @re_privates.size
    @re_privates = @re_privates.page(params[:page])
  end

  def show
    @re_private = RePrivate.find(params[:id])
  end
end
