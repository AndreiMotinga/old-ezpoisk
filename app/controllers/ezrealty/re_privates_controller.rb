class Ezrealty::RePrivatesController < ApplicationController
  before_action :set_questions, only: :index
  # before_action :set_partners

  def index
    @re_privates = RePrivate.filter(params.slice(:state_id, :city_id,
                    :geo_scope, :fee, :duration, :post_type, :space,
                    :baths, :rooms, :min_price, :max_price, :sorted))
                    .page(params[:page])
  end

  def show
    @re_private = get_record(RePrivate, params[:id], ezrealty_re_privates_path)
  end

  private

  def set_questions
    @side_questions = Question.tagged_with("недвижимость").limit(10)
  end

  def set_partners
    @partner_ads = PartnerAds.new("Недвижимость", session)
  end
end
