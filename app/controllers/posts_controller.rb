class PostsController < ApplicationController
  def index
    @posts = Post.includes(:user)
                 .visible
                 .by_keyword(params[:keyword])
                 .category(params[:category])
                 .desc
                 .page(params[:page]).per(10)
    IncreaseImpressionsJob.perform_async(@posts.pluck(:id), "Post")
  end

  def show
    @post = Post.find(params[:id])
    IncreaseVisitsJob.perform_async(@post.id, 'Post') if @post
  end

  def destroy_all
    NewsCleanerJob.perform_async
    redirect_to all_posts_path
  end

  def all
    @posts = Post.invisible
                 .category(params[:category])
                 .today
  end

  def import
    NewsImporterJob.perform_async
    redirect_to all_posts_path
  end
end
