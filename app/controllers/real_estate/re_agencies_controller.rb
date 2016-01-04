class RealEstate::ReAgenciesController < ApplicationController
  layout "real_estate"
  def index
    @re_agencies = ReAgency.filter(params.slice(:state_id, :city_id))
    @re_agencies = geo_scope(@re_agencies) if geo_scoped_params?
    @total = @re_agencies.size
    @re_agencies = @re_agencies.page(params[:page])
  end

  def show
    @re_agency = ReAgency.find(params[:id])
  end
end
