class Ezrealty::ReFinancesController < ApplicationController
  def index
    re_finances = ReFinance.filter(params.slice(:state_id, :city_id, :geo_scope))
                           .order("updated_at desc")
    @re_finances = re_finances.page(params[:page])
  end

  def show
    @re_finance = get_record ReFinance,
                            params[:id],
                            ezrealty_re_finances_path
  end
end
