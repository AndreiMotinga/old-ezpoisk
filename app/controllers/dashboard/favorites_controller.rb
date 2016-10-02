class Dashboard::FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    ids = Favorite.saved
                  .where(user_id: current_user.id, favorable_type: model.to_s)
                  .pluck(:favorable_id)
    @records = model.includes(:state, :city)
                    .where(id: ids)
                    .page(params[:page])

    respond_to do |format|
      format.html
      format.js { render partial: "shared/index",
                         locals: { records: @records } }
    end
  end

  private

  def model
    name = params[:type].present? ? params[:type] : "RePrivate"
    [RePrivate, Job, Sale, Service].find { |m| m.name == name }
  end
end
