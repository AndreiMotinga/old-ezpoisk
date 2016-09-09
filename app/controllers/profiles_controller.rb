class ProfilesController < ApplicationController
  before_action :set_user

  def show
    unless current_user == @user
      @user.increment!(:impressions_count)
      ProfileNotifierJob.perform_async(@user.id) if @user.impressions_count == 10
    end
  end

  def posts
    @posts = @user.posts.page(params[:page])
    respond_to do |format|
      format.html
      format.js { render partial: "shared/index", locals: { records: @posts } }
    end
  end

  def listings
    @listings = Entry.where(user_id: @user.id)
                     .where.not(enterable_type: ["Post", "Answer", "Question"])
                     .includes(enterable: [:state, :city])
                     .page(params[:page])
    respond_to do |format|
      format.html
      format.js { render partial: "shared/index", locals: { records: @listings } }
    end
  end

  def answers
    @answers = @user.answers.includes(:taggings).page(params[:page])
    respond_to do |format|
      format.html
      format.js { render partial: "shared/index", locals: { records: @answers } }
    end
  end

  def gallery
    @pictures = @user.gallery.pictures.page(params[:page]).per(30)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
