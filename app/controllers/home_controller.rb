class HomeController < ApplicationController
  def index
    # todo only select name and avatar
    @posts = Post.includes(:user)
                 .home
                 .visible
                 .desc
                 .page(params[:page]).per(10)
  end

  def about
  end
end
