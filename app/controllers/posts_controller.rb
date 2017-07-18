class PostsController < ApplicationController
  layout "answers"
  def index
    @posts = Post.includes(:user).page(params[:page])
    respond_to do |format|
      format.html
      format.js { render partial: "shared/index", locals: { records: @posts } }
    end
  end

  def show
    @post = Post.find(params[:id])
  end
end
