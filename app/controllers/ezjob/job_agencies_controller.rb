class Ezjob::JobAgenciesController < ApplicationController
  def index
    @job_agencies = JobAgency
      .filter(params.slice(:state_id, :city_id, :geo_scope))
      .page(params[:page])
  end

  def show
    @job_agency = get_record(JobAgency, params[:id], ezrealty_re_agencies_path)
    impressionist @job_agency if @job_agency.try(:active)
  end
end
