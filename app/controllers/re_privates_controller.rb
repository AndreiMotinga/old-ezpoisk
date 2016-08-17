class RePrivatesController < ApplicationController
  def index
    @re_privates = RePrivate.includes(:state, :city)
                            .filter(sliced_params).page(params[:page])
    IncreaseImpressionsJob.perform_async(@re_privates.pluck(:id), "RePrivate")

    respond_to do |format|
      format.html
      format.js { render partial: "shared/index",
                         locals: { records: @re_privates } }
    end
  end

  def show
    @re_private = get_record(RePrivate, params[:id], re_privates_path)
    if @re_private.try(:active?)
      @new_comment = Comment.build_from(@re_private, current_user.try(:id )|| 4, "")
    end
  end

  private

  def sliced_params
    params.slice(:state_id, :city_id, :geo_scope, :fee, :duration, :post_type,
                 :space, :baths, :rooms, :min_price, :max_price, :sorted)
  end
end
