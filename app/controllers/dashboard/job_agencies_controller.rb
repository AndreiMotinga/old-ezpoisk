class Dashboard::JobAgenciesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_job_agency, only: [:edit, :update, :destroy]

  def new
    @job_agency = JobAgency.new state_id: current_user.state_id,
                                city_id: current_user.city_id,
                                active: true,
                                phone: current_user.phone,
                                email: current_user.email
  end

  def edit
  end

  def create
    @job_agency = current_user.job_agencies.build(job_agency_params)

    if verify_recaptcha && @job_agency.save
      SlackNotifierJob.perform_async(@job_agency.id, "JobAgency" )
      AdminMailerJob.perform_async(@job_agency.id, "JobAgency")
      GeocodeJob.perform_async(@job_agency.id, "JobAgency")
      redirect_to edit_dashboard_job_agency_path(@job_agency),
                  notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :new
    end
  end

  def update
    address_changed = address_changed?(@job_agency, job_agency_params)
    if @job_agency.update(job_agency_params)
      GeocodeJob.perform_async(@job_agency.id, "JobAgency") if address_changed
      redirect_to edit_dashboard_job_agency_path(@job_agency),
                  notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :edit
    end
  end

  def destroy
    @job_agency.destroy
    redirect_to dashboard_path, notice: I18n.t(:post_removed)
  end

  private

  def set_job_agency
    @job_agency = current_user.job_agencies.find(params[:id])
  end

  def job_agency_params
    params.require(:job_agency).permit(:title,
                                      :street,
                                      :phone,
                                      :fax,
                                      :email,
                                      :site,
                                      :description,
                                      :active,
                                      :state_id,
                                      :city_id,
                                      :logo,
                                      :user_id )
  end
end
