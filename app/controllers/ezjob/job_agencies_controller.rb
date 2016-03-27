class Ezjob::JobAgenciesController < ApplicationController
  before_action :set_questions, only: :index

  def index
    @job_agencies = JobAgency
      .filter(params.slice(:state_id, :city_id, :geo_scope))
      .page(params[:page])
  end

  def show
    @job_agency = get_record(JobAgency, params[:id], ezrealty_re_agencies_path)
    impressionist(@job_agency, nil, unique: [:session_hash]) if @job_agency.try(:active)
  end

  private

  def set_questions
    @side_questions = Question.tagged_with("работа").limit(10)
  end
end
