class RealEstate::RePrivatesController < ApplicationController
  def index
    re_privates = RePrivate.includes(:state, :city)
                  .filter(params.slice(:state_id,
                                       :city_id,
                                       :geo_scope,
                                       :fee,
                                       :duration,
                                       :post_type,
                                       :space,
                                       :baths,
                                       :rooms,
                                       :min_price,
                                       :max_price,
                                       :sorted))
    @re_privates = re_privates.page(params[:page])
  end

  def show
    @re_private = get_record RePrivate,
                             params[:id],
                             real_estate_re_privates_path
  end
end
