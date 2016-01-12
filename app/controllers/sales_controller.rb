class SalesController < ApplicationController
  def index
    sales = Sale.includes(:state, :city).filter(params.slice(:state_id,
                                                             :city_id,
                                                             :category,
                                                             :keyword,
                                                             :geo_scope))
    @sales = sales.page(params[:page])
  end

  def show
    @sale = get_record Sale,
                       params[:id],
                       sales_path
  end
end
