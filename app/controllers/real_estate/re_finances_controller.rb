class RealEstate::ReFinancesController < ApplicationController
  def index
    ReFinance.connection.execute "SELECT setseed(#{rand_cookie})"
    re_finances = ReFinance.filter(params.slice(:state_id, :city_id, :geo_scope))
                          .order("RANDOM ()")
    @re_finances = re_finances.page(params[:page])
  end

  def show
    @re_agency = get_record ReFinance,
                            params[:id],
                            real_estate_re_finances_path
  end
end
