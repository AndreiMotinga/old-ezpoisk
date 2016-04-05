class NewsController < ApplicationController
  layout :resolve_layout
  # before_action :set_partners
  before_action :set_post, only: [:edit, :show, :update, :destroy]

  def index
    @questions = Question.order("impressions_count desc").page(params[:page]).per(35)
    @news_posts = Post.by_category(params[:category]).for_homepage.desc.page(params[:page]).per(9)
    @main = Post.main_posts.by_category(params[:category]).desc.page(params[:page]).per(5)
  end

  def all
    @posts = Post.where("created_at >= ?", Time.zone.now.beginning_of_day)
      .by_category(params[:category]).desc
  end

  def show
    @questions = Question.order("impressions_count desc").limit(10)
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

  def resolve_layout
    "home" if action_name == "all" || action_name == "edit"
  end

  def post_params
    params.require(:post).permit(:title, :text, :category, :interesting, :link,
                                 :description, :video_url, :main, :show_on_homepage, :image_remote_url,
                                 :user_id)
  end

  def set_post
    if Post.exists?(params[:id])
      @post = Post.find(params[:id])
      @post.update_column(:impressions_count, @post.impressions_count+1)
    else
      redirect_to news_index_path, alert: I18n.t(:news_post_not_found)
    end
  end

  def set_partners
    @partner_ads = PartnerAds.new("Недвижимость", session)
  end
end
