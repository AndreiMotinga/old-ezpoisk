class Ezrealty::ReAgenciesController < ApplicationController
  def index
    @re_agencies = ReAgency
      .filter(params.slice(:state_id, :city_id, :geo_scope))
      .page(params[:page])
  end

  def show
    @re_agency = get_record ReAgency,
      params[:id],
      ezrealty_re_agencies_path
  end
end
