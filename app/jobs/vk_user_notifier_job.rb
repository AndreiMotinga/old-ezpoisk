# enqueues vk user notfier job
class VkUserNotifierJob
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'

  def perform(id, model)
    return if Rails.env.development?
    @record = model.constantize.find_by_id(id)
    return if !@record || !@record.try(:active) || !@record.vk.present?
    VkUserNotifier.new(@record).notify
  end
end
