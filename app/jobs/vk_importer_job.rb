# imports records from vk
class VkImporterJob
  include Sidekiq::Worker

  def perform(type)
    VkImporter.new(type).import
  end
end
