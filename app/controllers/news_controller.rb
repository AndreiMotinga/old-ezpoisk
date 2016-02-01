class NewsController < ApplicationController
  before_action :set_post, only: [:edit, :show, :update]
  layout :resolve_layout

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
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to news_index_path(category: @post.category), notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :logo, :category,
                                 :important, :description, :main,
                                 :show_on_homepage)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def resolve_layout
    case action_name
    when "edit"
      "plain"
    else
      "application"
    end
  end
end
