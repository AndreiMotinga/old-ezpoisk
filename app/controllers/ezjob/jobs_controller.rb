class Ezjob::JobsController < ApplicationController
  def index
    @jobs = Job.filter(params.slice(:state_id,
                                    :city_id,
                                    :post_type,
                                    :category,
                                    :geo_scope)).page(params[:page])
  end

  def show
    @job = get_record(Job, params[:id], ezjob_jobs_path)
    impressionist @job if @job.try(:active)
  end
end
