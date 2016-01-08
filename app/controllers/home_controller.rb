# home page
class HomeController < ApplicationController
  def index
    @posts = Post.last(5)
  end
end
