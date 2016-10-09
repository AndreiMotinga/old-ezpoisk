class Dashboard::JobsController < ApplicationController
  before_action :set_job, only: [:edit, :update, :destroy]

  def index
    @jobs = current_user.jobs.includes(:state, :city).page(params[:page])
    respond_to do |format|
      format.html
      format.js do
        render partial: "shared/index", locals: { records: @jobs }
      end
    end
  end

  def new
    @job = Job.new(state_id: current_user.try(:state_id),
                   city_id: current_user.try(:city_id),
                   active: true,
                   phone: current_user.try(:phone),
                   email: current_user.try(:new_email))
  end

  def edit
  end

  def create
    @job = Job.new(job_params)
    @job.user = current_user
    if @job.save
      do_maintenance
      run_create_notifications
      redirect_on_create
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :new
    end
  end

  def update
    address_changed = address_changed?(@job, job_params)
    if @job.update(job_params)
      do_maintenance
      GeocodeJob.perform_async(@job.id, "Job") if address_changed
      run_update_notifications
      redirect_to update_redirect_path, notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :edit
    end
  end

  def destroy
    SlackNotifierJob.perform_async(@job.id, "Job", 'destroy')
    @job.destroy
    redirect_to destroy_redirect_path, notice: I18n.t(:post_removed)
  end

  private

  def redirect_on_create
    if @job.user
      redirect_to(
        edit_dashboard_job_path(@job),
        notice: I18n.t(:post_created)
      )
    else
      redirect_to(
        edit_dashboard_job_path(@job, token: @job.token),
        notice: I18n.t(:post_created_wr)
      )
    end
  end

  def update_redirect_path
    if params[:token].present?
      edit_dashboard_job_path(@job, token: params[:token])
    else
      edit_dashboard_job_path(@job)
    end
  end

  def run_update_notifications
    unless current_user.try(:team_member?)
      SlackNotifierJob.perform_async(@job.id, "Job", 'update')
    end
    @job.entry.try(:touch)
  end

  def run_create_notifications
    SlackNotifierJob.perform_async(@job.id, "Job")
    GeocodeJob.perform_async(@job.id, "Job")
    FbExporterJob.perform_in(23.minutes, @job.id, "Job")
    VkExporterJob.perform_in(21.minutes, @job.id, "Job")
    @job.create_entry(user: current_user)
    create_subscription(@job)
  end

  private

  def set_job
    if current_user.try(:admin?)
      @job = Job.find(params[:id])
    elsif params[:token].present?
      @job = Job.find(params[:id])
      @job = nil unless @job.token == params[:token]
    else
      @job = current_user.jobs.find(params[:id])
    end
  end

  def job_params
    params.require(:job).permit(:title, :phone, :email, :text,
                                :active, :street, :state_id, :city_id,
                                :logo, :category, :subcategory, :source,
                                :vk, :fb, :remote, tag_list: [])
  end

  def destroy_redirect_path
    params[:token].present? ? root_path : dashboard_jobs_path
  end

  def do_maintenance
    @job.clear_phone!
    @job.update_cached_tags
  end
end
