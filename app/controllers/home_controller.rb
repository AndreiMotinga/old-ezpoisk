# home page
class HomeController < ApplicationController
  def index
    @posts = Post.first(5)
  end
end
