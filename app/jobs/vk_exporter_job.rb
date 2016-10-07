# notifies vk group of new listings
class VkExporterJob
  include Sidekiq::Worker

  def perform(id, model)
    return unless Rails.env.production?
    VkExporter.new(id, model)
  end
end
