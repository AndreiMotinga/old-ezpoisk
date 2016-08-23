class ProfilesController < ApplicationController
  before_action :set_user

  def show
    @user.increment!(:impressions_count)
  end

  def contacts
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
                     .where.not(enterable_type: ["Post", "Question"])
                     .includes(enterable: [:state, :city])
                     .page(params[:page])
    respond_to do |format|
      format.html
      format.js { render partial: "shared/index", locals: { records: @listings } }
    end
  end

  def answers
    @answers = @user.answers.includes(question: :taggings).page(params[:page])
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
