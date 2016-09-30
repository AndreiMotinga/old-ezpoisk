class FeedsController < ApplicationController
  # todo clean up
  def index
    type = params[:type].present? ? params[:type].constantize : RePrivate

    if type == Post
      @listings = type.visible.today
    elsif type == Answer
      @listings = type.today
    else
      @listings = type.today.includes(:state, :city)
    end
  end

  def import
    ImporterJob.perform_async(params[:id])
    redirect_to root_path
  end
end
