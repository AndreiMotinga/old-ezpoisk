class ArticlesController < ApplicationController
  def index
    @articles = model.includes(:user)
    @articles = @articles.where(user_id: params[:user_id]) if params[:user_id].present?
    @articles = @articles.where("created_at >= ?", params[:start]) if params[:start].present?
    @articles = @articles.where("created_at <= ?", params[:end]) if params[:end].present?
    @articles = @articles.order(created_at: :desc).page(params[:page]).per(300)
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def model
    params[:model].present? ? params[:model].constantize : Post
  end
end
