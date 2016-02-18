class NewsController < ApplicationController
  before_action :set_post, only: [:edit, :show, :update, :destroy]

  def index
    category = params[:category]
    subcategory = params[:subcategory]
    if category.blank?
      posts = Post.order("created_at desc")
    else
      posts = Post.by_category(category).order("created_at desc")
      posts = posts.by_subcategory(subcategory) unless subcategory.blank?
    end
    @posts = posts.page params[:page]
  end

  def show
    @side_posts = Post.by_category(@post.category).desc.with_logo.limit(10)
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to news_path(@post), notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to :back, notice: I18n.t(:post_removed)
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :category,
                                 :main, :show_on_homepage, :image_remote_url)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
