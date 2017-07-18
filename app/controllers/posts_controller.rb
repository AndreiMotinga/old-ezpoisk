class PostsController < ApplicationController
  layout "answers"
  def index
    @posts = Post.includes(:user).page(params[:page])
    respond_to do |format|
      format.html
      format.js { render partial: "shared/index", locals: { records: @posts } }
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      SlackNotifierJob.perform_async(@post.id, "Post")
      # redirect_to @post, notice: I18n.t(:p_created)
      redirect_to @post, notice: "Пост добавлен"
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
