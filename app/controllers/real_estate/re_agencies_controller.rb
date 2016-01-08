class RealEstate::ReAgenciesController < ApplicationController
  layout "real_estate"
  def index
    re_agencies = ReAgency.filter(params.slice(:state_id, :city_id, :geo_scope))
    @re_agencies = re_agencies.page(params[:page])
  end

  def show
    @re_agency = get_record ReAgency,
                            params[:id],
                            real_estate_re_agencies_path
  end
end
