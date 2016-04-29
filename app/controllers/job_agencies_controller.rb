class JobAgenciesController < ApplicationController
  before_action :set_questions, only: :index
  before_action :set_partners, only: :index

  def index
    @job_agencies = Service.job_agencies.filter(
      params.slice(:state_id, :city_id, :geo_scope)
    ).page(params[:page])
  end

  def show
    @job_agency = get_record(Service, params[:id], job_agencies_path)
  end

  private

  def set_questions
    @side_questions = Question.tagged_with("работа").limit(10)
  end

  def set_partners
    state_id = session[:state_id]
    return if state_id == 0
    @partner_ads = PartnerAds.new(state_id, "Работа")
  end
end
