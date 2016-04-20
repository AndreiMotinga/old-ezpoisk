class RePrivatesController < ApplicationController
  before_action :set_questions, only: :index
  before_action :set_partners, only: :index

  def index
    @re_privates = RePrivate.filter(params.slice(:state_id, :city_id,
                    :geo_scope, :fee, :duration, :post_type, :space,
                    :baths, :rooms, :min_price, :max_price, :sorted))
                    .page(params[:page])
  end

  def show
    @re_private = get_record(RePrivate, params[:id], re_privates_path)
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
