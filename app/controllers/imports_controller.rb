class ImportsController < ApplicationController
  def index
  end

  def vk
    VkImporterJob.perform_async(params[:category])
    render :index
  end

  def fb
    FbImporterJob.perform_async(params[:category])
    render :index
  end
end
