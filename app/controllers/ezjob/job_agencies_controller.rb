class Ezjob::JobAgenciesController < ApplicationController
  before_action :set_questions, only: :index

  def index
    @job_agencies = JobAgency
      .filter(params.slice(:state_id, :city_id, :geo_scope))
      .page(params[:page])
    @partner_ads = PartnerAds.new("Работа", 1, 1, 1)
  end

  def show
    @job_agency = get_record(JobAgency, params[:id], ezrealty_re_agencies_path)
    if @job_agency.try(:active)
      impressionist(@job_agency, nil, unique: [:session_hash])
      @partner_ads = PartnerAds.new("Работа", 1, nil, nil)
    end
  end

  private

  def set_questions
    @side_questions = Question.tagged_with("работа").limit(10)
  end
end
