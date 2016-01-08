#todo: refactor + test
class SalesController < ApplicationController
  layout "sales"

  def index
    if geo_scoped_params?
      @sales = geo_scope(Sale.all)
    else
      @sales = Sale.filter(params.slice(:state_id, :city_id))
    end

    unless params[:category].blank? || params[:category] == "Все"
      @sales = @sales.where(category: params[:category])
    end

    keyword = params[:keyword]
    unless keyword.blank?
      query = "title LIKE ? OR description LIKE ?"
      @sales = @sales.where(query, "%#{keyword}%", "%#{keyword}%")
    end

    @total = @sales.size
    @sales = @sales.page(params[:page])
  end

  def show
    @sale = Sale.find(params[:id])
  end
end
