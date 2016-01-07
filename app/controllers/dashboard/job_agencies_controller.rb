# create tests
class Dashboard::JobAgenciesController < ApplicationController
  layout "dashboard"
  before_action :authenticate_user!
  before_action :set_job_agency, only: [:edit, :update, :destroy]

  def index
    @job_agencies = current_user.job_agencies
  end

  def new
    @job_agency = JobAgency.new
  end

  def edit
  end

  def create
    @job_agency = current_user.job_agencies.build(job_agency_params)

    if @job_agency.save
      GeocodeJob.perform_async(@job_agency.id, "JobAgency")
      redirect_to edit_dashboard_job_agency_path(@job_agency),
                  notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :new
    end
  end

  def update
    if @job_agency.update(job_agency_params)
      GeocodeJob.perform_async(@job_agency.id, "JobAgency") if address_changed?
      redirect_to edit_dashboard_job_agency_path(@job_agency),
                  notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :edit
    end
  end

  def destroy
    @job_agency.destroy
    redirect_to dashboard_job_agencies_url,
                notice: I18n.t(:post_removed)
  end

  private

  def address_changed?
    return true if @job_agency.street != job_agency_params[:street]
    return true if @job_agency.state != job_agency_params[:state]
    return true if @job_agency.city != job_agency_params[:city]
  end

  def set_job_agency
    @job_agency = JobAgency.find(params[:id])
  end

  def job_agency_params
    params.require(:job_agency).permit(:title,
                                      :street,
                                      :phone,
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
