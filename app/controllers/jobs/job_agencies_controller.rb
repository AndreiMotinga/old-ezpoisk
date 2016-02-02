class Jobs::JobAgenciesController < ApplicationController
  def index
    JobAgency.connection.execute "SELECT setseed(#{rand_cookie})"
    job_agencies = JobAgency.includes(:state, :city)
                            .filter(params.slice(:state_id, :city_id, :geo_scope))
                            .order("RANDOM ()")
    @job_agencies = job_agencies.page(params[:page])
  end

  def show
    @job_agency = get_record JobAgency,
                             params[:id],
                             real_estate_re_agencies_path
  end
end
