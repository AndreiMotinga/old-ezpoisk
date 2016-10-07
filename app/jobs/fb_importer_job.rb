# imports records from vk
class FbListingImporterJob
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'

  def perform(type)
    FbListingImporter.new(type).import
  end
end
