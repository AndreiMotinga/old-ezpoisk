# frozen_string_literal: true

class PostsController < PagesController
  before_action :authenticate_user!, except: [:index, :tag, :show]
  before_action :set_post, only: [:edit, :update, :destroy]
  after_action(only: [:index, :tag]) { create_show_impressions(@posts) }
  after_action(only: :show) { create_visit_impression(@post)  }

  def index
    @popular = Post.order(created_at: :desc).take(5)
    @posts = Post.includes(:user)
                 .published
                 .order(created_at: :desc)
                 .page(params[:page])
    @top, @left, @right = Partner.get
    respond_to do |format|
      format.html
      format.js { render partial: "shared/index", locals: { records: @posts } }
    end
  end

  def tag
    @popular = Comment.popular
    @posts = Post.includes(:user)
                 .published
                 .order(created_at: :desc)
                 .tagged_with(params[:tag])
                 .page(params[:page])
    @top, @left, @right = Partner.get(tags: params[:tag])
    respond_to do |format|
      format.html { render :index }
      format.js { render partial: "shared/index", locals: { records: @posts } }
    end
  end

  def new
    @post = Post.new
    @top = Partner.get(limit: 1)
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
    @popular = Comment.popular
    @top, @right, @inline = Partner.get(limit: 3, tags: @post.tag_list)
  end

  def edit
    @top = Partner.get(limit: 1, tags: @post.tag_list)
  end

  def update
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
    params.require(:post).permit(:title, :text, :published_at, tag_list: [])
  end

  def set_post
    @post = Post.find(params[:id])
    @post = nil unless current_user.try(:can_edit?, @post)
  end
end
