# imports records from vk
class ImporterJob
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'

  def perform(type)
    VkImporter.new(type).import
    FbImporter.new(type).import
  end
end
