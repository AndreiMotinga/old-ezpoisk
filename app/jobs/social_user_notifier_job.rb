# enqueues vk or fb user notfier job
class SocialUserNotifierJob
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'

  def perform(id, model)
    return if Rails.env.development?
    @record = model.constantize.find_by_id(id)
    return if !@record || !@record.try(:active)
    if @record.vk.present?
      VkUserNotifier.new(@record).notify
    elsif @record.fb.present?
      FbUserNotifier.new(@record).notify
    end
  end
end
