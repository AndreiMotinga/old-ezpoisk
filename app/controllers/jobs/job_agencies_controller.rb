class Jobs::JobAgenciesController < ApplicationController
  layout "jobs"

  def index
    job_agencies = JobAgency.filter(params.slice(:state_id,
                                                 :city_id,
                                                 :geo_scope))
    @job_agencies = job_agencies.page(params[:page])
  end

  def show
    @job_agency = get_record JobAgency,
                             params[:id],
                             real_estate_re_agencies_path
  end
end
