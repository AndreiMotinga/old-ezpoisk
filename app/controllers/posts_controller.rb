class PostsController < ApplicationController
  before_action :set_partners
  before_action :set_post, only: [:show, :edit, :update]

  def all
    @posts = Post.invisible.today
  end

  def index
    @questions = Question.order("updated_at desc").page(params[:page]).per(25)
    @posts = Post.visible.by_keyword(params[:keyword]).desc.page(params[:page]).per(10)
  end

  def show
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
    Post.invisible.destroy_all
  end

  private

  def set_post
    if Post.exists?(params[:id])
      @post = Post.find(params[:id])
      @post.update_column(:impressions_count, @post.impressions_count+1)
    else
      redirect_to posts_path, alert: I18n.t(:news_post_not_found)
    end
  end

  def set_partners
    state_id = session[:state_id]
    return if state_id == 0
    @partner_ads = PartnerAds.new(state_id, "Новости")
  end

  def post_params
    params.require(:post).permit(:title, :text, :image_remote_url, :visible)
  end
end
