class Ezrealty::ReCommercialsController < ApplicationController
  before_action :set_questions, only: :index
  # before_action :set_partners

  def index
    @re_commercials = ReCommercial.filter(params.slice(:state_id, :city_id,
                        :geo_scope, :post_type, :space, :min_price, :max_price,
                        :sorted)).page(params[:page])
  end

  def show
    @re_commercial = get_record(ReCommercial,
                                params[:id],
                                ezrealty_re_commercials_path)
    if @re_commercial.try(:active)
      impressionist(@re_commercial, nil, unique: [:session_hash])
    end
  end

  private

  def set_questions
    @side_questions = Question.tagged_with("недвижимость").limit(10)
  end

  def set_partners
    @partner_ads = PartnerAds.new("Недвижимость", session)
  end
end
