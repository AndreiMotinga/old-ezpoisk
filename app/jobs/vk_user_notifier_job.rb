# notifies vk user of message, created on his behalf
class VkUserNotifierJob
  include Sidekiq::Worker

  def perform(user_id, id, model)
    return unless Rails.env.production?
    record = model.constantize.find_by_id(id)
    return unless record || !record.try(:active)
    begin
      VkNotifier.new.send_message(user_id, record)
    rescue Exception => error
      puts "=================  FORBIDDEN ===================== "
    end
  end
end
