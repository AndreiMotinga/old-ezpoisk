class HomeController < ApplicationController
  def index
    @posts = Post.for_homepage.limit(12).desc
    @main = Post.main
  end
end
