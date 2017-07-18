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
      redirect_to @post, notice: I18n.t(:p_created)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: I18n.t(:p_updated)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: I18n.t(:p_destroyed)
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
