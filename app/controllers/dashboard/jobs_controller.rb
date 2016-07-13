class Dashboard::JobsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_job, only: [:edit, :update, :destroy]

  def new
    email = current_user.admin? ? "" : current_user.email
    @job = Job.new(state_id: current_user.profile_state_id,
                   city_id: current_user.profile_city_id,
                   active: true,
                   phone: current_user.profile_phone,
                   email: email)
  end

  def edit
  end

  def create
    @job = current_user.jobs.build(job_params)
    if @job.save
      SlackNotifierJob.perform_async(@job.id, "Job")
      GeocodeJob.perform_async(@job.id, "Job")
      @job.create_entry
      redirect_to edit_dashboard_job_path(@job), notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :new
    end
  end

  def update
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
    @job.destroy
    redirect_to dashboard_path, notice: I18n.t(:post_removed)
  end

  private

  def set_job
    @job = current_user.jobs.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :phone, :email, :description,
                                :active, :street, :state_id, :city_id,
                                :logo, :category, :subcategory, :source)
  end
end
