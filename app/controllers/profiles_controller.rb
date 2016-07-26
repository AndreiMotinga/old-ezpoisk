class ProfilesController < ApplicationController
  before_action :set_profile

  def show
    @profile.increment!(:impressions_count)
  end

  def contacts
  end

  def posts
    @posts = @profile.user.posts.page(params[:page])
  end

  def listings
    @listings = Entry.includes(enterable: :state).page(params[:page])
  end

  def answers
    @answers = @profile.answers.includes(:question).page(params[:page])
  end

  def pictures
    @pictures = @profile.pictures.page(params[:page]).per(30)
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end
end
