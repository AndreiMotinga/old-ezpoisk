class PostsController < ApplicationController
  def index
    @posts = Post.includes(:user)
                 .visible
                 .desc
                 .page(params[:page])
    IncreaseImpressionsJob.perform_async(@posts.pluck(:id), "Post")
    respond_to do |format|
      format.html
      format.js { render partial: "shared/index", locals: { records: @posts } }
    end
  end

  def tag
    @posts = Post.visible
                   .includes(:user)
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
    @posts = Post.includes(:user).visible.older(@post.created_at)
                                         .desc.page(params[:page])
    IncreaseImpressionsJob.perform_async(@posts.pluck(:id), "Post")
    respond_to do |format|
      format.html
      format.js { render partial: "shared/index", locals: { records: @posts } }
    end
  end
end
