class NewsController < ApplicationController
  def index
    @posts = Post.news
  end
end
