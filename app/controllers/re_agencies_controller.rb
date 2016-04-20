class ReAgenciesController < ApplicationController
  before_action :set_partners, only: :index
  before_action :set_questions, only: :index

  def index
    @re_agencies = ReAgency.filter(params.slice(:state_id, :city_id, :geo_scope))
                           .page(params[:page])
  end

  def show
    @re_agency = get_record(ReAgency, params[:id], re_agencies_path)
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
