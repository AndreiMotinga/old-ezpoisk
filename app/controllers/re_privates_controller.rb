class RePrivatesController < ApplicationController
  def index
    redirect_to search_re_privates_path(sliced_params) if search?
    @re_privates = RePrivate.includes(:state, :city)
                            .filter(sliced_params)
                            .page(params[:page])
    IncreaseImpressionsJob.perform_async(@re_privates.pluck(:id), "RePrivate")

    respond_to do |format|
      format.html
      format.js { render partial: "shared/index",
                         locals: { records: @re_privates } }
    end
  end

  def search
    @re_privates = RePrivate.includes(:state, :city)
                            .filter(sliced_params)
                            .page(params[:page])
    IncreaseImpressionsJob.perform_async(@re_privates.pluck(:id), "RePrivate")
    respond_to do |format|
      format.html { render :index }
      format.js { render partial: "shared/index",
                         locals: { records: @re_privates } }
    end
  end

  def show
    @re_private = get_record(RePrivate, params[:id], re_privates_path)
  end
end
