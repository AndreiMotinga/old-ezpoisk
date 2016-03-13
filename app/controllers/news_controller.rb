class NewsController < ApplicationController
  before_action :set_post, only: [:edit, :show, :update, :destroy]

  def index
    @questions = Question.answered.order("updated_at desc").page(params[:page]).per(41)
    @news_posts = Post.by_category(params[:category]).for_homepage.desc.page(params[:page]).per(10)
    @main = Post.main_posts.by_category(params[:category]).desc.page(params[:page]).per(7)
  end

  def all
    @posts = Post.where("created_at >= ?", Time.zone.now.beginning_of_day)
      .by_category(params[:category]).desc
  end

  def show
    @side_posts = Post.by_category(@post.category).desc.with_logo.limit(17)
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
    params.require(:post).permit(:title, :text, :category, :interesting,
                      :video_url, :main, :show_on_homepage, :image_remote_url)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
