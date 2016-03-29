class Dashboard::FavoritesController < ApplicationController
  before_action :set_partners
  before_action :authenticate_user!

  def index
    @favorites = UserFavorites.new(current_user).favorite_posts
    @favorites = Kaminari.paginate_array(@favorites).page(params[:page])
  end

  private

  def set_partners
    @partner_ads = PartnerAds.new("Панель Управления", 1, nil, nil)
  end
end
