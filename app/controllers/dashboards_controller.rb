class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    type = params[:type]
    type = type.present? ? type.constantize : RePrivate

    if type == Post
      @records = type.includes(:user)
    else
      @records = type.includes(:state, :city)
    end
    @records = @records.where(user_id: current_user.id).page(params[:page])
  end
end
