class FeedsController < ApplicationController
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

  def importer
  end

  def import
    VkImporterJob.perform_async(params[:category])
    render :importer
  end
end
