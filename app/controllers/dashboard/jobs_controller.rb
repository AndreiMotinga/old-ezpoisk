# add tests
class Dashboard::JobsController < ApplicationController
  layout "dashboard"
  before_action :authenticate_user!
  before_action :set_job, only: [:edit, :update, :destroy]

  def index
    @jobs = current_user.jobs
  end

  def new
    @job = Job.new
  end

  def edit
  end

  def create
    @job = current_user.jobs.build(job_params)

    if @job.save
      GeocodeJob.perform_async(@job.id, "Job")
      redirect_to edit_dashboard_job_path(@job),
                  notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :new
    end
  end

  def update
    if @job.update(job_params)
      GeocodeJob.perform_async(@job.id, "Job") if address_changed?
      redirect_to edit_dashboard_job_path(@job),
                  notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :edit
    end
  end

  def destroy
    @job.destroy
    redirect_to dashboard_jobs_path,
                notice: I18n.t(:post_removed)
  end

  private

  # move to ApplicationController
  def address_changed?
    return true if @job.state != job_params[:state]
    return true if @job.city != job_params[:city]
  end

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title,
                                :phone,
                                :email,
                                :description,
                                :active,
                                :state_id,
                                :city_id,
                                :logo,
                                :category,
                                :subcategory)
  end
end
