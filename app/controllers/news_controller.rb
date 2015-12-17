class NewsController < ApplicationController
  def index
    @posts = Post.news.page params[:page]
  end

  def show
    @post = Post.find(params[:id])
  end
end
