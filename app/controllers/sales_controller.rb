class SalesController < ApplicationController
  def index
    redirect_to search_sales_path(sliced_params) if search?
    @sales = Sale.includes(:state, :city)
                 .filter(sliced_params)
                 .page(params[:page])
    IncreaseImpressionsJob.perform_async(@sales.pluck(:id), "Sale")
    respond_to do |format|
      format.html
      format.js { render partial: "shared/index", locals: { records: @sales } }
    end
  end

  def search
    @sales = Sale.includes(:state, :city)
                 .filter(sliced_params)
                 .page(params[:page])
    IncreaseImpressionsJob.perform_async(@sales.pluck(:id), "Sale")
    respond_to do |format|
      format.html { render :index }
      format.js { render partial: "shared/index", locals: { records: @sales } }
    end
  end

  def show
    @sale = get_record(Sale, params[:id], sales_path)
  end
end
