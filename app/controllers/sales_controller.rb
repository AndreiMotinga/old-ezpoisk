class SalesController < ApplicationController
  def index
    @sales = Sale.includes(:state, :city)
                 .filter(sliced_params)
                 .page(params[:page])
    IncreaseImpressionsJob.perform_async(@sales.pluck(:id), "Sale")
    respond_to do |format|
      format.html
      format.js { render partial: "shared/index", locals: { records: @sales } }
    end
  end

  def show
    @sale = get_record(Sale, params[:id], sales_path)
    if @sale.try(:active?)
      @new_comment = Comment.build_from(@sale, current_user.try(:id )|| 4, "")
    end
  end

  private

  def sliced_params
    params.slice(:state_id, :city_id, :category, :keyword, :sorted, :geo_scope)
  end
end
