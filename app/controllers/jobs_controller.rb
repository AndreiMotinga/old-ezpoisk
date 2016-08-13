class JobsController < ApplicationController
  def index
    @jobs = Job.includes(:state, :city, :taggings)
               .filter(sliced_params)
               .page(params[:page])
    IncreaseImpressionsJob.perform_async(@jobs.pluck(:id), "Job")
  end

  def show
    @job = get_record(Job, params[:id], jobs_path)
    if @job.try(:active?)
      @new_comment = Comment.build_from(@job, current_user.try(:id )|| 4, "")
    end
  end

  private

  def sliced_params
    params.slice(:state_id, :city_id, :keyword, :category,:geo_scope, :tag_list)
  end
end
