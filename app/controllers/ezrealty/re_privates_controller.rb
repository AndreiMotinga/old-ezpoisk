class Ezrealty::RePrivatesController < ApplicationController
  before_action :set_questions, only: :index

  def index
    @re_privates = filtered.page(params[:page])
    @partner_ads = PartnerAds.new("Недвижимость", 1, 1, 1)
  end

  def show
    @re_private = get_record(RePrivate, params[:id], ezrealty_re_privates_path)
    if @re_private.try(:active)
      impressionist(@re_private, nil, unique: [:session_hash])
      @partner_ads = PartnerAds.new("Недвижимость", 1, nil, nil)
    end
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

  def set_questions
    @side_questions = Question.tagged_with("недвижимость").limit(10)
  end

  def set_partners
    @partner_ads = PartnerAds.new("Недвижимость", 1, 1, 1)
  end
end
