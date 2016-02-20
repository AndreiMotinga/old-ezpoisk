class Ezrealty::ReCommercialsController < ApplicationController
  def index
    re_commercials  = ReCommercial.filter(params.slice(:state_id,
                                                       :city_id,
                                                       :geo_scope,
                                                       :post_type,
                                                       :space,
                                                       :min_price,
                                                       :max_price,
                                                       :sorted))
    if params[:sorted].blank?
      re_commercials = re_commercials.order("created_at desc")
    end
    @re_commercials = re_commercials.page(params[:page])
  end

  def show
    @re_commercial = get_record ReCommercial,
                                params[:id],
                                ezrealty_re_commercials_path
  end
end
