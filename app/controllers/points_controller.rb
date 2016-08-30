class PointsController < ApplicationController
  def create
    return unless current_user
    user_id = params[:user_id].to_i
    author_id = current_user.id
    return if user_id == author_id
    Point.create(user_id: user_id, author_id: author_id)
  end
end
