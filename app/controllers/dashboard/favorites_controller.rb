class Dashboard::FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorites = UserFavorites.new(current_user).favorite_posts
    @favorites = Kaminari.paginate_array(@favorites).page(params[:page])
  end
end
