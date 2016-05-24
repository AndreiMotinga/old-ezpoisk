class Dashboard::FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorites = Kaminari.paginate_array(favorite_posts).page(params[:page])
  end

  private

  def favorite_posts
    # todo create saved scope
    current_user.favorites.where(saved: true).map { |f| f.favorable}
  end
end
