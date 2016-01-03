class Dashboard::ReAgenciesController < ApplicationController
  layout "dashboard"
  before_action :authenticate_user!
  before_action :set_re_agency, only: [:edit, :update, :destroy]

  def index
    @re_agencies = current_user.re_agencies
  end

  def new
    @re_agency = ReAgency.new
  end

  def edit
  end

  def create
    @re_agency = current_user.re_agencies.build(re_agency_params)

    if @re_agency.save
      GeocodeJob.perform_async(@re_agency.id, "ReAgency")
      redirect_to edit_dashboard_re_agency_path(@re_agency),
                  notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :new
    end
  end

  def update
    if @re_agency.update(re_agency_params)
      GeocodeJob.perform_async(@re_agency.id, "ReAgency") if address_changed?
      redirect_to edit_dashboard_re_agency_path(@re_agency),
                  notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :edit
    end
  end

  def destroy
    @re_agency.destroy
    redirect_to dashboard_re_agencies_url,
                notice: I18n.t(:post_removed)
  end

  private

  def address_changed?
    return true if @re_agency.street != re_agency_params[:street]
    return true if @re_agency.state != re_agency_params[:state]
    return true if @re_agency.city != re_agency_params[:city]
  end

  def set_re_agency
    @re_agency = ReAgency.find(params[:id])
  end

  def re_agency_params
    params.require(:re_agency).permit(:title,
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
