# imports records from vk
class VkImporterJob
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'

  def perform(type)
    VkImporter.new(type).import
  end
end
