# imports records from vk
class FbImporterJob
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'

  def perform(type)
    FbImporter.new(type).import
  end
end
