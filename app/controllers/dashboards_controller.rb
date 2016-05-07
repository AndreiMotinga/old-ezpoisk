class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @users_posts = ListingsAggregator.new(
      current_user, params[:keyword], params[:model]
    ).listings
    @users_posts = Kaminari.paginate_array(@users_posts).page(params[:page])
  end
end
