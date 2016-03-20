class Ezrealty::ReCommercialsController < ApplicationController
  def index
    @re_commercials = filtered.page(params[:page])
  end

  def show
    @re_commercial = get_record(ReCommercial,
                                params[:id],
                                ezrealty_re_commercials_path)
    impressionist @re_commercial if @re_commercial.try(:active)
  end

  private

  def filtered
    ReCommercial.filter(params.slice(:state_id,
                                     :city_id,
                                     :geo_scope,
                                     :post_type,
                                     :space,
                                     :min_price,
                                     :max_price,
                                     :sorted))
  end
end
