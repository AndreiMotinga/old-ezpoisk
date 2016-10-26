class ImportsController < ApplicationController
  def index
  end

  def vk
    MediaImporterJob.perform_async("public/vk_groups.json", Vk::GroupLoader)
    render :index
  end

  def fb
    MediaImporterJob.perform_async("public/fb_groups.json", Fb::GroupLoader)
    render :index
  end
end
