# home page
class HomeController < ApplicationController
  def index
    @posts = Post.first(10)
  end
end
