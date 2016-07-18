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
    @listings = ListingsAggregator.new(@profile.user).listings
    @listings = Kaminari.paginate_array(@listings).page(params[:page])
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
