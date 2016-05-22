class FavoritesController < ApplicationController
  def create
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
    params.require(:favorite).permit(
      :favorable_id, :favorable_type, :favorite, :hidden
    )
  end

  # todo move to model
  def favorite
    current_user.favorites.where(
      favorable_id: favorite_params[:favorable_id],
      favorable_type: favorite_params[:favorable_type],
      favorite: favorite_params[:favorite],
      hidden: favorite_params[:hidden]
    ).first
  end
end
