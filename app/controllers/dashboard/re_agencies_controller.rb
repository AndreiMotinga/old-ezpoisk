class Dashboard::ReAgenciesController < ApplicationController
  layout "dashboard"
  before_action :authenticate_user!
  before_action :set_re_agency, only: [:edit, :update, :destroy]

  def index
    @re_agencies = current_user.re_agencies.page params[:page]
  end

  def new
    @re_agency = ReAgency.new state_id: current_user.state_id,
                              city_id: current_user.city_id,
                              active: true,
                              phone: current_user.phone
  end

  def edit
    redirect_to dashboard_path if @re_agency.user != current_user
  end

  def create
    @re_agency = current_user.re_agencies.build(re_agency_params)

    if @re_agency.save
      AdminMailerJob.perform_async(@re_agency.id, "ReAgency")
      GeocodeJob.perform_async(@re_agency.id, "ReAgency")
      redirect_to edit_dashboard_re_agency_path(@re_agency),
                  notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :new
    end
  end

  def update
    return unless @re_agency.user == current_user
    address_changed = address_changed?(@re_agency, re_agency_params)
    if @re_agency.update(re_agency_params)
      GeocodeJob.perform_async(@re_agency.id, "ReAgency") if address_changed
      redirect_to edit_dashboard_re_agency_path(@re_agency),
                  notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :edit
    end
  end

  def destroy
    return unless @re_agency.user == current_user
    @re_agency.destroy if @re_agency.user == current_user
    redirect_to dashboard_re_agencies_url,
                notice: I18n.t(:post_removed)
  end

  private

  def set_re_agency
    @re_agency = ReAgency.find(params[:id])
  end

  def re_agency_params
    params.require(:re_agency).permit(:title,
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
