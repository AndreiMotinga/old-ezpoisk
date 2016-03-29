class DashboardsController < ApplicationController
  before_action :set_partners
  before_action :authenticate_user!

  def show
    @users_posts = UsersPostsAggregator
              .new(current_user, params[:keyword], params[:model])
              .users_posts
    @users_posts = Kaminari.paginate_array(@users_posts).page(params[:page])
  end

  private

  def set_partners
    @partner_ads = PartnerAds.new("Панель Управления", 1, nil, nil)
  end
end
