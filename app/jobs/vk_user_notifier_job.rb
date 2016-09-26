class VkUserNotifierJob
  include Sidekiq::Worker

  def perform(user_id, id, model)
    return unless Rails.env.production?
    VkUserNotifier.new(user_id, id, model)
  end
end
