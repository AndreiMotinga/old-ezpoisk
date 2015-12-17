# home page
class HomeController < ApplicationController
  def index
    @news_posts = Post.news
  end
end
