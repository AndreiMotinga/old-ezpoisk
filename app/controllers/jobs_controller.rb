class JobsController < ApplicationController
  def index
    redirect_to search_jobs_path(sliced_params) if search?
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
      format.js { render partial: "shared/index", locals: { records: @jobs } }
    end
  end

  def search
    @jobs = Job.includes(:state, :city, :taggings)
               .filter(sliced_params)
               .page(params[:page])
    IncreaseImpressionsJob.perform_async(@jobs.pluck(:id), "Job")
    respond_to do |format|
      format.html { render :index }
      format.js { render partial: "shared/index", locals: { records: @jobs } }
    end
  end

  def show
    @job = get_record(Job, params[:id], jobs_path)
  end
end
