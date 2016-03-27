class Ezrealty::ReCommercialsController < ApplicationController
  before_action :set_questions, only: :index

  def index
    @re_commercials = filtered.page(params[:page])
  end

  def show
    @re_commercial = get_record(ReCommercial,
                                params[:id],
                                ezrealty_re_commercials_path)
    impressionist(@re_commercial, nil, unique: [:session_hash]) if @re_commercial.try(:active)
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

  def set_questions
    @side_questions = Question.tagged_with("недвижимость").limit(10)
  end
end
