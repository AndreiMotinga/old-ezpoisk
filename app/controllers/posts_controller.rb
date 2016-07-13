class PostsController < ApplicationController
  # before_action :set_partners
  before_action :set_post, only: [:show, :edit, :update]

  def index
    page = params[:page]
    @posts = Post.includes(:user)
                 .visible
                 .by_keyword(params[:keyword])
                 .desc
                 .page(page).per(10)
  end

  def show
    @post.update_column(:impressions_count, @post.impressions_count + 1)
  end

  def edit
  end

  def update
    if @post.update(post_params) && @post.visible?
      @post.create_entry(updated_at: @post.updated_at) unless @post.entry
      redirect_to post_path(@post)
    else
      render :edit, alert: "There was a problem"
    end
  end

  def destroy_all
    NewsCleanerJob.perform_async
    redirect_to all_posts_path
  end

  def all
    @posts = Post.invisible.today
  end

  def import
    NewsImporterJob.perform_async
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
