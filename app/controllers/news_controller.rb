class NewsController < ApplicationController
  def index
    @posts = Post.news
  end

  def show
    @post = Post.find(params[:id])
  end
end
