class Dashboard::JobsController < ApplicationController
  layout "dashboard"
  before_action :authenticate_user!
  before_action :set_job, only: [:edit, :update, :destroy]

  def index
    @jobs = current_user.jobs.page params[:page]
  end

  def new
    @job = Job.new state_id: current_user.state_id,
                   city_id: current_user.city_id,
                   active: true,
                   phone: current_user.phone,
                   email: current_user.email
  end

  def edit
    redirect_to dashboard_path if @job.user != current_user
  end

  def create
    @job = current_user.jobs.build(job_params)

    if @job.save
      AdminMailerJob.perform_async(@job.id, "Job")
      GeocodeJob.perform_async(@job.id, "Job")
      redirect_to edit_dashboard_job_path(@job),
                  notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :new
    end
  end

  def update
    return unless @job.user == current_user
    address_changed = address_changed?(@job, job_params)
    if @job.update(job_params)
      GeocodeJob.perform_async(@job.id, "Job") if address_changed
      redirect_to edit_dashboard_job_path(@job),
                  notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :edit
    end
  end

  def destroy
    return unless @job.user == current_user
    @job.destroy
    redirect_to dashboard_jobs_path,
                notice: I18n.t(:post_removed)
  end

  private

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
                                :post_type)
  end
end
