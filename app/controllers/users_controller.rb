class UsersController < ApplicationController
  before_action :set_user

  def show
    @listings = @user.listings.includes(:state, :city).page(params[:listings_page])
    @answers = @user.answers.page(params[:answers_page])
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
    elsif params[:pictures_page]
      @param = :pictures_page
      @records = @pictures
    elsif params[:reviews_page]
      @param = :reviews_page
      @records = @reviews
    end
  end

  def set_user
    @user = User.includes(:state, :city).find(params[:id])
  end
end
