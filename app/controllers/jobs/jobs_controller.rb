class Jobs::JobsController < ApplicationController
  layout "jobs"

  def index
    jobs = Job.filter(params.slice(:state_id,
                                   :city_id,
                                   :post_type,
                                   :category,
                                   :geo_scope))
    @jobs = jobs.page(params[:page])
  end

  def show
    @job = get_record(Job, params[:id], jobs_jobs_path)
  end
end
