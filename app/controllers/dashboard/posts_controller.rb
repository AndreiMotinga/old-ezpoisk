class Dashboard::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:edit, :update, :destroy]

  def index
    @posts = current_user.posts
    @posts = @posts.page(params[:page])
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      SlackNotifierJob.perform_async(@post.id, "Post")
      @post.create_entry(user: current_user)
      redirect_to edit_dashboard_post_path(@post), notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :new
    end
  end

  def update
    if @post.update(post_params)
      @post.entry.try(:touch)
      redirect_to edit_dashboard_post_path(@post), notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to dashboard_path, notice: I18n.t(:post_removed)
  end

  private

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :text, :image)
  end
end
