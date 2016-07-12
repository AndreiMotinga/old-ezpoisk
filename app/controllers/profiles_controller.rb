class ProfilesController < ApplicationController
  before_action :set_profile

  def show
    @profile.increment!(:impressions_count)
  end

  def contacts
  end

  def posts
    @posts = @profile.user.posts
    @posts = @posts.page(params[:page])
  end

  def listings
    @listings = ListingsAggregator.new(@profile.user).listings
    @listings = Kaminari.paginate_array(@listings).page(params[:page])
  end

  def answers
    @answers = @profile.answers.includes(:question)
    @answers = @answers.page(params[:page])
  end

  def reviews
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end
end
