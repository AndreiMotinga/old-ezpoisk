class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    posts = UsersPostsAggregator
              .new(current_user, params[:keyword], params[:model])
              .users_posts
    @users_posts = Kaminari.paginate_array(posts).page(params[:page])
  end
end
