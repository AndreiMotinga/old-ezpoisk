class RealEstate::ReAgenciesController < ApplicationController
  layout "real_estate"
  def index
    @re_agencies = ReAgency.all.page params[:page]
  end

  def show
    @re_agency = ReAgency.find(params[:id])
  end
end
