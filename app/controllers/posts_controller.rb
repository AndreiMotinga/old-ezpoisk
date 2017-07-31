class PostsController < ApplicationController
  layout "answers"
  before_action :authenticate_user!, except: [:index, :tag, :show]
  before_action :set_post, only: [:edit, :update, :destroy]

  def index
    @popular = Comment.popular
    @posts = Post.includes(:user).page(params[:page])
    respond_to do |format|
      format.html
      format.js { render partial: "shared/index", locals: { records: @posts } }
    end
  end

  def tag
    @popular = Comment.popular
    @posts = Post.includes(:user)
                 .tagged_with(params[:tag], any: true)
                 .page(params[:page])

    respond_to do |format|
      format.html { render :index }
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
    params.require(:post).permit(:title, :text, tag_list: [])
  end

  def set_post
    @post = Post.find(params[:id])
    @post = nil unless current_user.try(:can_edit?, @post)
  end
end
