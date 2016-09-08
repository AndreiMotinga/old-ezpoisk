class PostsController < ApplicationController
  def index
    @posts = Post.includes(:user, :taggings)
                 .visible
                 .desc
                 .page(params[:page]).per(10)
    IncreaseImpressionsJob.perform_async(@posts.pluck(:id), "Post")
    respond_to do |format|
      format.html
      format.js { render partial: "shared/index", locals: { records: @posts } }
    end
  end

  def tag
    @posts = Post.visible
                   .includes(:user, :taggings)
                   .tagged_with(params[:tag], any: true)
                   .page(params[:page])
    IncreaseImpressionsJob.perform_async(@posts.pluck(:id), "Post")

    respond_to do |format|
      format.html { render :index }
      format.js { render partial: "shared/index", locals: { records: @posts } }
    end
  end

  def show
    @post = Post.find(params[:id])
    IncreaseVisitsJob.perform_in(14.minutes, @post.id, 'Post') if @post
  end

  # todo move these to dashboard
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
                 .category(params[:category])
                 .order('title desc')
                 .today
  end

  def import
    NewsImporterJob.perform_async
    redirect_to posts_all_path
  end
end
