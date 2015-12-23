# home page
class HomeController < ApplicationController
  def index
    @news_posts = Post.news.last(7)
  end
end
