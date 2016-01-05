# home page
class HomeController < ApplicationController
  def index
    @news_posts = Post.last(5)
  end
end
