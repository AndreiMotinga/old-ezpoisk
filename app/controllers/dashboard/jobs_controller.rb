class Dashboard::JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_job, only: [:edit, :update, :destroy]

  def new
    @job = Job.new(state_id: current_user.state_id,
                   city_id: current_user.city_id,
                   active: true,
                   phone: current_user.phone,
                   email: current_user.new_email)
  end

  def edit
  end

  def create
    @job = current_user.jobs.build(job_params)
    if @job.save
      run_create_notifications
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
      run_update_notifications
      redirect_to update_redirect_path, notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :edit
    end
  end

  def destroy
    @job.destroy
    redirect_to destroy_redirect_path, notice: I18n.t(:post_removed)
  end

  private

  def update_redirect_path
    if params[:token].present?
      edit_dashboard_job_path(@job, token: params[:token])
    else
      edit_dashboard_job_path(@job)
    end
  end

  def run_update_notifications
    SlackNotifierJob.perform_async(@job.id, "Job", 'update')
    @job.entry.try(:touch)
  end

  def run_create_notifications
    SlackNotifierJob.perform_async(@job.id, "Job")
    GeocodeJob.perform_async(@job.id, "Job")
    @job.create_entry(user: current_user)
    create_subscription(@job)
  end

  def set_job
    if params[:token].present?
      @job = Job.find(params[:id])
      @job = nil unless @job.token == params[:token]
    else
      @job = current_user.jobs.find(params[:id])
    end
  end

  def job_params
    params.require(:job).permit(:title, :phone, :email, :description,
                                :active, :street, :state_id, :city_id,
                                :logo, :category, :subcategory, :source,
                                tag_list: [])
  end
end
