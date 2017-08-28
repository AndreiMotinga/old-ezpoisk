class ArticlesController < ApplicationController
  def index
    @articles = model.includes(:user)
    @articles = @articles.where(user_id: user_id) if user_id.present?
    @articles = @articles.where("created_at >= ?", start_date) if params[:start_date].present?
    @articles = @articles.where("created_at <= ?", end_date) if params[:end_date].present?
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

  def user_id
    params[:user_id]
  end

  def start_date
    start = params[:start_date]
    DateTime.new(start["year"].to_i, start["month"].to_i, start["day"].to_i)
  end

  def end_date
    end_prm = params[:end_date]
    DateTime.new(end_prm["year"].to_i, end_prm["month"].to_i, end_prm["day"].to_i)
  end
end
