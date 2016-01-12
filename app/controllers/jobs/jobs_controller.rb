class Jobs::JobsController < ApplicationController
  def index
    jobs = Job.includes(:state, :city).filter(params.slice(:state_id,
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
