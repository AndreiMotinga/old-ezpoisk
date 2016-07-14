class PointsController < ApplicationController
  def create
    return unless current_user
    @profile = Profile.find(params[:profile_id])
    Point.create(user: current_user, profile: @profile)
  end
end
