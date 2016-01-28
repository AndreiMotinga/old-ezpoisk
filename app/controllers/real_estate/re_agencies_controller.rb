class RealEstate::ReAgenciesController < ApplicationController
  def index
    re_agencies = ReAgency.includes(:state, :city)
                  .filter(params.slice(:state_id, :city_id, :geo_scope))
                  .order("RANDOM ()")
    @re_agencies = re_agencies.page(params[:page])
  end

  def show
    @re_agency = get_record ReAgency,
                            params[:id],
                            real_estate_re_agencies_path
  end
end
