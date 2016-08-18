class FeedsController < ApplicationController
  def index
    type = params[:type].present? ? params[:type].constantize : RePrivate

    if type == Post
      @listings = type.visible.today
    else
      @listings = type.today.includes(:state, :city)
    end
  end
end
