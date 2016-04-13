class JobAgenciesController < ApplicationController
  before_action :set_questions, only: :index
  # before_action :set_partners

  def index
    @job_agencies = JobAgency
      .filter(params.slice(:state_id, :city_id, :geo_scope))
      .page(params[:page])
  end

  def show
    @job_agency = get_record(JobAgency, params[:id], job_agencies_path)
  end

  private

  def set_questions
    @side_questions = Question.tagged_with("работа").limit(10)
  end

  def set_partners
    @partner_ads = PartnerAds.new("Работа", session)
  end
end
