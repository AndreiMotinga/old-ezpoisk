class Dashboard::FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorites = current_user.saved_listings
    @favorites = Kaminari.paginate_array(@favorites).page(params[:page])
  end
end
