# imports records from vk
class MediaImporterJob
  include Sidekiq::Worker
  sidekiq_options queue: "critical"

  def perform(file, loader)
    Media::Importer.new(file, loader.constantize).import
  end
end
