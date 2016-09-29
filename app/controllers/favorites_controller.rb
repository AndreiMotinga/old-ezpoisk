class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorite(favorite_params)
    if favorite
      favorite.destroy
      render json: { status: 204 }
    else
      current_user.favorites.create(favorite_params)
      render json: { status: 201 }
    end
  end

  def touch
    @rec = record_params["type"].constantize.find(record_params[:id])
    @rec.touch
    @rec.entry.touch
  end

  private

  def record_params
    params.require(:record).permit(:id, :type)
  end

  def favorite_params
    params.require(:favorite).permit(
      :favorable_id, :favorable_type, :saved, :hidden
    )
  end
end
