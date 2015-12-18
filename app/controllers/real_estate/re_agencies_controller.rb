class RealEstate::ReAgenciesController < ApplicationController
  def index
    @re_agencies = ReAgency.all.page params[:page]
  end

  def show
    @re_agency = ReAgency.find(params[:id])
  end
end
