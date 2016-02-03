class SalesController < ApplicationController
  def index
    sales = Sale.filter(params.slice(:state_id,
                                     :city_id,
                                     :category,
                                     :keyword,
                                     :geo_scope))
                .order("created_at desc")
    @sales = sales.page(params[:page])
  end

  def show
    @sale = get_record Sale,
                       params[:id],
                       sales_path
  end
end
