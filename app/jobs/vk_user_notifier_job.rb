# sends message to vk user about listing added on his behalf
class VkUserNotifierJob
  include Sidekiq::Worker

  def perform(user_id, id, model)
    return unless Rails.env.production?
    @record = model.constantize.find_by_id(id)
    @user_id = user_id
    @i = 0
    @token = TOKENS[@i]
    @vk = VkontakteApi::Client.new(@token)
    send_message if should_send?
  end

  def send_message
    return unless @token
    begin
      puts "ANDREI: Sending message with token #{@i} - #{@token}"
      @vk.messages.send(user_id: @user_id, message: SocialMessage.message(@record))
    rescue Exception => error
      puts "ANDREI: Rescuing response error"
      set_new_token
      send_message
    end
  end

  def should_send?
    return if !@record || !@record.try(:active)
    messages = @vk.messages.getHistory(user_id: @user_id)
    return if messages.first != 0 # user didn't get message from us yet
    true
  end

  def set_new_token
    @i += 1
    @token = TOKENS[@i]
    @vk = VkontakteApi::Client.new(@token)
  end

  TOKENS = [
    ENV["VK_ANDREI_TOKEN"],
    ENV["VK_TITOV_TOKEN"],
    ENV["VK_OLEG_TOKEN"]
  ]
end
