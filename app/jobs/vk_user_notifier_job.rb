# enqueues vk user notfier job
class VkUserNotifierJob
  include Sidekiq::Worker

  def perform(user_id, id, model)
    # todo return if Rails.env.development?
    VkUserNotifier.new(user_id, id, model)
  end
end
