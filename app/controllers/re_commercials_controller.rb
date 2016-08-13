class ReCommercialsController < ApplicationController
  def index
    @re_commercials = ReCommercial.includes(:state, :city)
                                  .filter(sliced_params)
                                  .page(params[:page])
    IncreaseImpressionsJob
      .perform_async(@re_commercials.pluck(:id), "ReCommercial")
  end

  def show
    @re_commercial = get_record(ReCommercial, params[:id], re_commercials_path)
    if @re_commercial.try(:active?)
      @new_comment = Comment.build_from(@re_commercial, current_user.try(:id )|| 4, "")
    end
  end

  private

  def sliced_params
    params.slice(:state_id, :city_id, :geo_scope, :post_type, :space,
                 :min_price, :max_price, :sorted)
  end
end
