class ImportsController < ApplicationController
  def index
  end

  def vk
    VkListingImporterJob.import
    render :index
  end

  def fb
    FbListingImporterJob.import
    render :index
  end
end
