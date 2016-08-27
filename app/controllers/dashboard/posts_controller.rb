class Dashboard::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:edit, :update, :destroy]

  def index
    @posts = current_user.posts
    @posts = @posts.page(params[:page])
  end

  def new
    @post = Post.new(category: "user", home: true)
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      run_create_notifications
      redirect_to post_path(@post), notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :new
    end
  end

  def update
    visible = @post.visible
    if @post.update(post_params)
      run_update_notifications(visible)
      redirect_to post_path(@post), notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :edit
    end
  end

  def destroy
    @id = @post.id
    @post.destroy

    respond_to do |format|
      format.html { redirect_to dashboard_path, notice: I18n.t(:post_removed) }
      format.js
    end
  end

  private

  def run_create_notifications
    SlackNotifierJob.perform_async(@post.id, "Post")
    FacebookNotifierJob.perform_in(9.minutes, @post.id, "Post")
    VkNotifierJob.perform_in(14.minutes, @post.id, "Post")
  end

  def run_update_notifications(visible)
    # post was imported and then updated by editor to be visible
    if visible != @post.visible
      FacebookNotifierJob.perform_in(9.minutes, @post.id, "Post")
      VkNotifierJob.perform_in(14.minutes, @post.id, "Post")
    end
    unless current_user.try(:team_member?)
      SlackNotifierJob.perform_async(@post.id, "Post", 'update')
    end
  end

  def set_post
    if current_user.editor?
      @post = Post.find(params[:id])
    else
      @post = current_user.posts.find(params[:id])
    end
  end

  def post_params
    params.require(:post).permit(:title, :text, :image_remote_url, :visible,
                                 :summary, :home, :category, :source,
                                 category_ids: [])
  end
end
