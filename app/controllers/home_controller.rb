class HomeController < ApplicationController
  def index
    @posts = Post.for_homepage.limit(25).desc
    @main = Post.main
  end
end
