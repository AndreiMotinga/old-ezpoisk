class FavoritesController < ApplicationController
  def create_favorite
    favorite_post = Favorite.where(
      user_id: current_user.id,
      post_id: params[:favorite][:post_id],
      post_type: params[:favorite][:post_type],
      favorite: true
    ).first

    if favorite_post
      favorite_post.destroy
      render json: {status: 204}
    else
      current_user.favorites.create(favorite_params)
      render json: {status: 201}
    end
  end

  def create_hidden
    hidden_post = Favorite.where(
      user_id: current_user.id,
      post_id: params[:favorite][:post_id],
      post_type: params[:favorite][:post_type],
      hidden: true
    ).first

    if hidden_post
      hidden_post.destroy
      render json: {status: 204}
    else
      current_user.favorites.create(favorite_params)
      render json: {status: 201}
    end
  end

  private

  def favorite_params
    params.require(:favorite).permit(:post_id, :post_type, :favorite, :hidden)
  end
end
