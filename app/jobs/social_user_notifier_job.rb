# enqueues vk or fb user notfier job
class SocialUserNotifierJob
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'

  def perform(id, model)
    return if Rails.env.development?
    @record = model.constantize.find_by_id(id)
    return if !@record || !@record.try(:active)
    if @record.vk.present?
      Vk::UserNotifier.new(@record)
    elsif @record.fb.present?
      Fb::UserNotifier.new(@record)
    end
  end
end
