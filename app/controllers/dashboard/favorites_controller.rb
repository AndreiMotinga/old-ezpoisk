class Dashboard::FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorites = Kaminari.paginate_array(favorite_posts).page(params[:page])
  end

  private

  def favorite_posts
    current_user.favorites.where(favorite: true).map do |favorite|
      model = favorite.post_type.constantize
      model.find_by_id(favorite.post_id)
    end
  end
end
