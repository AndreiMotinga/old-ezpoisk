class FavoritesController < ApplicationController
  def create_favorite
    if favorite_post
      favorite_post.destroy
      render json: { status: 204 }
    else
      current_user.favorites.create(favorite_params)
      render json: { status: 201 }
    end
  end

  def create_hidden
    if hidden_post
      hidden_post.destroy
      render json: { status: 204 }
    else
      current_user.favorites.create(favorite_params)
      render json: { status: 201 }
    end
  end

  private

  def favorite_post
    Favorite.where(
      user_id: current_user.id,
      favorable_id: params[:favorable_id],
      favorable_type: params[:favorable_type],
      favorite: true
    ).first
  end

  def hidden_post
    Favorite.where(
      user_id: current_user.id,
      favorable_id: params[:favorable_id],
      favorable_type: params[:favorable_type],
      hidden: true
    ).first
  end

  def favorite_params
    params.permit(:favorable_id, :favorable_type, :favorite, :hidden)
  end
end
