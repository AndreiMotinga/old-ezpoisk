class Dashboard::JobAgenciesController < ApplicationController
  layout "dashboard"
  before_action :authenticate_user!
  before_action :set_job_agency, only: [:edit, :update, :destroy]

  def index
    @job_agencies = current_user.job_agencies.page params[:page]
  end

  def new
    @job_agency = JobAgency.new state_id: current_user.state_id,
                                city_id: current_user.city_id,
                                phone: current_user.phone,
                                email: current_user.email
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
    return unless @job_agency.user == current_user
    if @job_agency.update(job_agency_params)
      if address_changed?(@job_agency, job_agency_params)
        GeocodeJob.perform_async(@job_agency.id, "JobAgency")
      end
      redirect_to edit_dashboard_job_agency_path(@job_agency),
                  notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :edit
    end
  end

  def destroy
    return unless @job_agency.user == current_user
    @job_agency.destroy
    redirect_to dashboard_job_agencies_url,
                notice: I18n.t(:post_removed)
  end

  private

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
