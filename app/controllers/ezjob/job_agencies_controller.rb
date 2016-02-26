class Ezjob::JobAgenciesController < ApplicationController
  def index
    job_agencies = JobAgency.filter(params.slice(:state_id, :city_id, :geo_scope))
                            .order("updated_at desc")
    @job_agencies = job_agencies.page(params[:page])
  end

  def show
    @job_agency = get_record JobAgency,
                             params[:id],
                             ezrealty_re_agencies_path
  end
end
