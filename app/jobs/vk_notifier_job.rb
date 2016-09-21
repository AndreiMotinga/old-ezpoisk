# notifies vk group of new listings
class VkNotifierJob
  include Sidekiq::Worker

  def perform(id, model)
    return if Rails.env.development?
    record = model.constantize.find(id)
    return unless record
    if model == "Post" || model == "Answer"
      VkNotifier.new.post_to_wall(record)
    else
      VkNotifier.new.post_to_topic(record)
    end
  end
end
