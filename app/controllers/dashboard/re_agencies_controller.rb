class Dashboard::ReAgenciesController < ApplicationController
  layout "dashboard"
  before_action :set_re_agency, only: [:show, :edit, :update, :destroy]

  def index
    @re_agencies = current_user.re_agencies
  end

  def show
  end

  def new
    @re_agency = ReAgency.new
  end

  def edit
  end

  def create
    @re_agency = current_user.re_agencies.build(re_agency_params)

    if @re_agency.save
      redirect_to dashboard_re_agency_path @re_agency,
                  notice: "Re agency was successfully created."
    else
      render :new
    end
  end

  def update
    if @re_agency.update(re_agency_params)
      redirect_to dashboard_re_agency_path(@re_agency),
                  notice: "Re agency was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @re_agency.destroy
    redirect_to dashboard_re_agencies_url,
                notice: "Re agency was successfully destroyed."
  end

  private

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
                                      :user_id )
  end
end
