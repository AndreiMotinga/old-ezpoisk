class PostsController < ApplicationController
  before_action :set_partners
  before_action :set_post, only: [:show, :edit, :update]

  def all
    @posts = Post.invisible.today
  end

  def import
    NewsImporterJob.perform_async
    redirect_to all_posts_path
  end

  def index
    page = params[:page]
    @posts = Post.visible.by_keyword(params[:keyword]).desc.page(page).per(10)
    @questions = Question.order("updated_at desc").page(page).per(25)
  end

  def show
    @post.increment!(:impressions_count)
    @questions = Question.order("updated_at desc").limit(10)
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit, alert: "There was a problem"
    end
  end

  def destroy_all
    NewsCleanerJob.perform_async
    redirect_to all_posts_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def set_partners
    @partner_ads = PartnerAds.new("Новости")
  end

  def post_params
    params.require(:post).permit(:title, :text, :image_remote_url, :visible)
  end
end
