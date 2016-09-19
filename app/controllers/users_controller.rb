class UsersController < ApplicationController
  before_action :set_user

  def show
    increase_impressions
    @listings = @user.listings.page(params[:listings_page])
    @answers = @user.answers.includes(:taggings).page(params[:answers_page])
    @posts = @user.posts.includes(:taggings).page(params[:posts_page])
    @pictures = @user.pictures.page(params[:pictures_page]).per(40)
    @reviews = @user.reviews.page(params[:reviews_page])
    set_records
  end

  private

  def set_records
    if params[:listings_page]
      @param = :listings_page
      @records = @listings
    elsif params[:answers_page]
      @param = :answers_page
      @records = @answers
    elsif params[:posts_page]
      @param = :posts_page
      @records = @posts
    elsif params[:pictures_page]
      @param = :pictures_page
      @records = @pictures
    elsif params[:reviews_page]
      @param = :reviews_page
      @records = @reviews
    end
  end

  def increase_impressions
    return if current_user == @user
    @user.increment!(:impressions_count)
    ProfileNotifierJob.perform_async(@user.id) if @user.impressions_count == 10
  end

  def set_user
    @user = User.find(params[:id])
  end
end
