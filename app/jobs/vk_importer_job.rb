# imports records from vk
class VkImporterJob
  include Sidekiq::Worker

  def perform
    VkImporter.import
  end
end
