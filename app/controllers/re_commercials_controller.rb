class ReCommercialsController < ApplicationController
  before_action :set_questions, only: :index
  before_action :set_partners, only: :index

  def index
    @re_commercials = ReCommercial.filter(params.slice(:state_id, :city_id,
                        :geo_scope, :post_type, :space, :min_price, :max_price,
                        :sorted)).page(params[:page])
  end

  def show
    @re_commercial = get_record(ReCommercial, params[:id], re_commercials_path)
  end

  private

  def set_questions
    @side_questions = Question.tagged_with("недвижимость").limit(10)
  end

  def set_partners
    state_id = session[:state_id]
    return if state_id == 0
    @partner_ads = PartnerAds.new(state_id, "Недвижимость")
  end
end
