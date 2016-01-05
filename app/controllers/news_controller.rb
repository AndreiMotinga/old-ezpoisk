class NewsController < ApplicationController
  def index
    category = params[:category]
    if category.blank?
      @posts = Post.all
    else
      @posts = Post.where("category LIKE ?", "%#{category}%")
    end
    @posts = @posts.page params[:page]
  end

  def show
    @post = Post.find(params[:id])
  end
end
