class Dashboard::ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: [:edit, :update, :destroy]

  def index
    @reviews = current_user.reviews.order("created_at desc").page(params[:page])
    respond_to do |format|
      format.html
      format.js do
        render partial: "shared/index", locals: { records: @reviews }
      end
    end
  end

  def new
    @review = Review.new
  end

  def edit
  end

  def create
    @review = current_user.reviews.build(review_params)
    @review.title = @review.listing.title
    if @review.save
      run_create_notifications
      redirect_to dashboard_reviews_path, notice: I18n.t(:review_created)
    else
      flash.now[:alert] = I18n.t(:review_not_saved)
      render :new, listing_id: params[:listing_id]
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
  end

  def run_create_notifications
    SlackNotifierJob.perform_async(@review.id, "Review")
  end

  def set_review
    if current_user.admin?
      @review = Review.find(params[:id])
    else
      @review = current_user.reviews.find(params[:id])
    end
  end

  def review_params
    params.require(:review).permit(:rating, :text, :listing_id)
  end
end
