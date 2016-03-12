class FavoritesController < ApplicationController
  def create
    if !user_signed_in?
      return render js: "window.location = '#{new_user_session_path}'"
    end

    favorite = Favorite.where(
      user_id: current_user.id,
      post_id: params[:favorite][:post_id],
      post_type: params[:favorite][:post_type]
    ).first

    if favorite
      favorite.destroy
      render json: {status: 204}
    else
      current_user.favorites.create(favorite_params)
      render json: {status: 201}
    end
  end

  private

  def favorite_params
    params.require(:favorite).permit(:post_id, :post_type)
  end
end
