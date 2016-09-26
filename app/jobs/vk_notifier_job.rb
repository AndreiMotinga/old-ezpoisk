# notifies vk group of new listings
class VkNotifierJob
  include Sidekiq::Worker

  def perform(id, model)
    return unless Rails.env.production?
    VkNotifier.new(id, model)
  end
end
