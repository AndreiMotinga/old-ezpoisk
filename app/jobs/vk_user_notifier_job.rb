# enqueues vk user notfier job
class VkUserNotifierJob
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'

  def perform(user_id, id, model)
    return if Rails.env.development?
    VkUserNotifier.new(user_id, id, model)
  end
end
