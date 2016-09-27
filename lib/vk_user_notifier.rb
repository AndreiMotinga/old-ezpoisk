# sends message to vk user about listing added on his behalf
class VkUserNotifier
  def initialize(user_id, id, model)
    @record = model.constantize.find_by_id(id)
    @user_id = user_id
    @i = 0
    @vk = VkontakteApi::Client.new(TOKENS[@i])
    # send_message if should_send?
  end

  def send_message
    begin
      puts "ANDREI: Sending message with token #{@i} - #{@vk}"
      @vk.messages.send(user_id: @user_id, message: SocialMessage.message(@record))
    rescue Exception => error
      puts "ANDREI: Rescuing response error"
      @i += 1
      @vk = VkontakteApi::Client.new(TOKENS[@i])
      send_message
    end
  end

  def should_send?
    return if !@record || !@record.try(:active)
    messages = @vk.messages.getHistory(user_id: @user_id)
    return if messages.first != 0 # user didn't get message from us yet
    true
  end

  TOKENS = [
    ENV["VK_ANDREI_TOKEN"],
    ENV["VK_OLEG_TOKEN"],
    ENV["VK_TITOV_TOKEN"]
  ]
end
