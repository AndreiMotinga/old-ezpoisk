class JobsController < ApplicationController
  def index
    @jobs = Job.includes(:state, :city, :taggings)
               .filter(sliced_params)
               .page(params[:page])
    IncreaseImpressionsJob.perform_async(@jobs.pluck(:id), "Job")
    respond_to do |format|
      format.html
      format.js { render partial: "shared/index",
                         locals: { records: @jobs } }
    end
  end

  def tag
    @jobs = Job.includes(:state, :city, :taggings)
               .tagged_with(params[:tag], any: true)
               .page(params[:page])
    IncreaseImpressionsJob.perform_in(1.minute, @jobs.pluck(:id), "Job")
    respond_to do |format|
      format.html { render :index }
      format.js { render partial: "shared/index",
                         locals: { records: @jobs } }
    end
  end

  def show
    @job = get_record(Job, params[:id], jobs_path)
  end

  private

  def sliced_params
    params.slice(:state_id, :city_id, :keyword, :category,:geo_scope, :tag_list)
  end
end
