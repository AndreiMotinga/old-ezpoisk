class Dashboard::ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: [:edit, :update, :destroy]

  def index
    @reviews = current_user.reviews.page(params[:page])
  end

  def new
    @review = Review.new
  end

  def edit
  end

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      run_create_notifications
      redirect_to dashboard_reviews_path, notice: I18n.t(:review_created)
    else
      flash.now[:alert] = I18n.t(:review_not_saved)
      render :new, service_id: params[:service_id]
    end
  end

  def update
    if @review.update(review_params)
      run_update_notifications
      redirect_to dashboard_reviews_path, notice: I18n.t(:review_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :edit
    end
  end

  def destroy
    SlackNotifierJob.perform_async(@review.id, "Review", 'destroyed')
    @review.destroy
    redirect_to dashboard_reviews_path, notice: I18n.t(:review_removed)
  end

  private

  def run_update_notifications
    SlackNotifierJob.perform_async(@review.id, "Review", "update")
    @review.entry.try(:touch)
  end

  def run_create_notifications
    SlackNotifierJob.perform_async(@review.id, "Review")
    @review.create_entry(user: current_user)
  end

  def set_review
    @review = current_user.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :text, :service_id)
  end
end
