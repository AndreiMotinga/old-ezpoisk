class Ezrealty::RePrivatesController < ApplicationController
  def index
    @re_privates = filtered.page(params[:page])
  end

  def show
    @re_private = get_record(RePrivate, params[:id], ezrealty_re_privates_path)
    IncreaseImpressionsCountJob.perform_async(params[:id], "RePrivate")
  end

  private

  def filtered
    RePrivate.filter(params.slice(:state_id,
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
  end
end
