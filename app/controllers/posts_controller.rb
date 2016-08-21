class PostsController < ApplicationController
  def index
    @posts = Post.includes(:user)
                 .visible
                 .by_keyword(params[:keyword])
                 .category(params[:category])
                 .desc
                 .page(params[:page]).per(10)
    IncreaseImpressionsJob.perform_async(@posts.pluck(:id), "Post")
    respond_to do |format|
      format.html
      format.js { render partial: "shared/index", locals: { records: @posts } }
    end
  end

  def show
    @post = Post.find(params[:id])
    IncreaseVisitsJob.perform_async(@post.id, 'Post') if @post
  end

  def destroy_all
    if params[:category]
      Post.invisible.category(params[:category]).delete_all
    else
      Post.invisible.delete_all
    end

    redirect_to posts_all_path
  end

  def all
    @posts = Post.invisible
                 .import_category(params[:category])
                 .order('title desc')
                 .today
  end

  def import
    NewsImporterJob.perform_async
    redirect_to posts_all_path
  end
end
