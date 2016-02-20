class Ezjob::JobsController < ApplicationController
  def index
    jobs = Job.filter(params.slice(:state_id,
                                   :city_id,
                                   :post_type,
                                   :category,
                                   :geo_scope))
              .order("created_at desc")
    @jobs = jobs.page(params[:page])
  end

  def show
    @job = get_record(Job, params[:id], ezjob_jobs_path)
  end
end
