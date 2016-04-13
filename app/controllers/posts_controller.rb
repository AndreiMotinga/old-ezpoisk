class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :show, :update, :destroy]

  def index
    @questions = Question.order("updated_at desc").page(params[:page]).per(25)
    @posts = Post.by_keyword(params[:keyword]).desc.page(params[:page]).per(10)
  end

  def show
    @questions = Question.order("updated_at desc").limit(10)
  end

  def set_post
    if Post.exists?(params[:id])
      @post = Post.find(params[:id])
      @post.update_column(:impressions_count, @post.impressions_count+1)
    else
      redirect_to posts_path, alert: I18n.t(:news_post_not_found)
    end
  end
end
