class Jobs::JobAgenciesController < ApplicationController
  layout "jobs"
  def index
    @job_agencies = JobAgency.filter(params.slice(:state_id, :city_id))
    @job_agencies = geo_scope(@job_agencies) if geo_scoped_params?
    @total = @job_agencies.size
    @job_agencies = @job_agencies.page(params[:page])
  end

  def show
    @job_agency = JobAgency.find(params[:id])
  end
end
