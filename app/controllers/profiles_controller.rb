class ProfilesController < ApplicationController
  layout "answers"

  def show
    @user = User.find(params[:id])
  end

  def listings
    @user = User.find(params[:id])
    @listings = @user.listings.includes(:state, :city).page(params[:page])
    respond_to do |format|
      format.html
      format.js do
        render partial: "shared/index", locals: { records: @listings }
      end
    end
  end

  def posts
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
    respond_to do |format|
      format.html
      format.js do
        render partial: "shared/index", locals: { records: @posts }
      end
    end
  end

  def questions
    @user = User.find(params[:id])
    @questions = @user.questions.page(params[:page])
    @tags = Question.tag_counts.sort_by(&:name)
    respond_to do |format|
      format.html
      format.js do
        render partial: "shared/index", locals: { records: @questions }
      end
    end
  end
end
