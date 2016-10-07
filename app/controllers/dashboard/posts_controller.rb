class Dashboard::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:edit, :update, :destroy]

  def index
    @posts = current_user.posts
                         .includes(:user, :taggings)
                         .desc
                         .page(params[:page])
    respond_to do |format|
      format.html
      format.js do
        render partial: "shared/index", locals: { records: @posts }
      end
    end
  end


  def new
    @post = Post.new(category: "user")
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      @post.update_cached_tags
      run_create_notifications
      redirect_to post_path(@post), notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :new
    end
  end

  def update
    if @post.update(post_params)
      @post.update_cached_tags
      run_update_notifications
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
      format.html do
        redirect_to dashboard_posts_path, notice: I18n.t(:post_removed)
      end
      format.js
    end
  end

  def destroy_all
    if params[:category]
      Post.invisible.category(params[:category]).delete_all
    else
      Post.invisible.delete_all
    end

    redirect_to all_dashboard_posts_path
  end

  def all
    @posts = Post.invisible
                 .category(params[:category])
                 .order('title desc')
                 .today
  end

  def import
    NewsImporterJob.perform_async
    redirect_to all_dashboard_posts_path
  end

  private

  def run_create_notifications
    SlackNotifierJob.perform_async(@post.id, "Post")
    FbExporterJob.perform_in(9.minutes, @post.id, "Post")
    VkExporterJob.perform_in(14.minutes, @post.id, "Post")
    @post.create_entry(user: current_user)
  end

  def run_update_notifications
    FbExporterJob.perform_in(9.minutes, @post.id, "Post")
    VkExporterJob.perform_in(14.minutes, @post.id, "Post")
    unless current_user.try(:team_member?)
      SlackNotifierJob.perform_async(@post.id, "Post", 'update')
    end
    @post.entry ? @post.entry.touch : @post.create_entry(user: current_user)
  end

  def set_post
    if current_user.admin?
      @post = Post.find(params[:id])
    else
      @post = current_user.posts.find(params[:id])
    end
  end

  def post_params
    params.require(:post).permit(:title, :text, :image_remote_url, :visible,
                                 :summary, :category, tag_list: [])
  end
end
