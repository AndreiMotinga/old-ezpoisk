class HomeController < ApplicationController
  def index
    @posts = Post.order("created_at desc").limit(10)
    @main = Post.main
  end
end
