class RealEstate::ReCommercialsController < ApplicationController
  layout "real_estate"
  def index
    re_commercials  = ReCommercial.filter(params.slice(:state_id,
                                                       :city_id,
                                                       :post_type,
                                                       :space,
                                                       :min_price,
                                                       :max_price,
                                                       :sort,
                                                       :geo_scope))
    @re_commercials = re_commercials.page(params[:page])
  end

  def show
    @re_commercial = get_record ReCommercial,
                                params[:id],
                                real_estate_re_commercials_path
  end
end
