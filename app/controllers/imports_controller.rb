class ImportsController < ApplicationController
  def index
  end

  def vk
    VkListingImporterJob.perform_async
    flash.now[:notice] = "Magic' in the air"
    render :index
  end

  def fb
    FbListingImporterJob.perform_async
    flash.now[:notice] = "Not so much, but who knows"
    render :index
  end
end
