class Ezrealty::ReAgenciesController < ApplicationController
  # before_action :set_partners
  before_action :set_questions, only: :index

  def index
    @re_agencies = ReAgency.filter(params.slice(:state_id, :city_id, :geo_scope))
                           .page(params[:page])
  end

  def show
    @re_agency = get_record(ReAgency, params[:id], ezrealty_re_agencies_path)
    impressionist(@re_agency, nil, unique: [:session_hash]) if @re_agency.try(:active)
  end

  private

  def set_questions
    @side_questions = Question.tagged_with("недвижимость").limit(10)
  end

  def set_partners
    @partner_ads = PartnerAds.new("Недвижимость", session)
  end
end
