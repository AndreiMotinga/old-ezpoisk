class Ezrealty::ReFinancesController < ApplicationController
  def index
    @re_finances = ReFinance
      .filter(params.slice(:state_id, :city_id, :geo_scope))
      .page(params[:page])
  end

  def show
    @re_finance = get_record ReFinance, params[:id], ezrealty_re_finances_path
    impressionist @re_finance if @re_finance.try(:active)
  end
end
