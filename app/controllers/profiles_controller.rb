class ProfilesController < ApplicationController
  before_action :set_user

  def show
    @user.increment!(:impressions_count)
  end

  def contacts
  end

  def posts
    @posts = @user.posts.page(params[:page])
  end

  def listings
    @listings = Entry.where.not(enterable_type: ["Post", "Question"])
                     .includes(enterable: [:state, :city])
                     .page(params[:page])
  end

  def answers
    @answers = @user.answers.includes(:question).page(params[:page])
  end

  def gallery
    @pictures = @user.gallery.pictures.page(params[:page]).per(30)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
