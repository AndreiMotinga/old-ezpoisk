class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @users_posts = UsersPostsAggregator.new(
      current_user, params[:keyword], params[:model]
    ).users_posts
    @users_posts = Kaminari.paginate_array(@users_posts).page(params[:page])
  end
end
