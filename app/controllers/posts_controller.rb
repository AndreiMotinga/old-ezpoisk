class PostsController < ApplicationController
  before_action :set_partners
  before_action :set_post, only: [:show]

  def index
    @questions = Question.order("updated_at desc").page(params[:page]).per(25)
    @posts = Post.by_keyword(params[:keyword]).desc.page(params[:page]).per(10)
  end

  def show
    @questions = Question.order("updated_at desc").limit(10)
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
end
