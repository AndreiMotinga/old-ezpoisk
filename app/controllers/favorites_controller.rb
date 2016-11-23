class FavoritesController < ApplicationController
  def create
    favorite = current_user.find_favorite(favorite_params)
    if favorite
      favorite.destroy
      render json: { status: 204 }
    else
      current_user.favorites.create(favorite_params)
      render json: { status: 201 }
    end
  end

  private

  def favorite_params
    params.require(:favorite)
          .permit(:favorable_id, :favorable_type, :saved, :hidden)
  end
end
