class Dashboard::FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    type = params[:type]
    type = type.present? ? type : "RePrivate"
    ids = Favorite.saved
                  .where(user_id: current_user.id, favorable_type: type)
                  .pluck(:favorable_id)
    @records = type.constantize
                   .includes(:state, :city)
                   .where(id: ids)
                   .page(params[:page])
  end
end
