class PointsController < ApplicationController
  def create
    return unless current_user
    @user = User.find(params[:user_id])
    return if @user.id == current_user.id
    Point.create(user_id: @user.id, author_id: current_user.id)
  end
end
