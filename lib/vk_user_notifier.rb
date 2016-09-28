# todo figure out a way to reset it.  options are
# manually via herokur restart
# run a bg job once 12? hours to call VkUserNotifier.vk_reset

# sends message to vk user about listing added on his behalf
class VkUserNotifier
  TOKENS = [
    ENV["VK_ANDREI_TOKEN"],
    ENV["VK_TITOV_TOKEN"],
    ENV["VK_OLEG_TOKEN"]
  ].freeze

  @@vk = VkontakteApi::Client.new(TOKENS[0])

  def initialize(user_id, id, model)
    @record = model.constantize.find_by_id(id)
    @user_id = user_id
  end

  def notify
    return unless should_notify?
    begin
      @@vk.messages.send(user_id: @user_id, message: Message.message(@record))
    rescue VkontakteApi::Error
      update_vk
      notify
    end
  end

  def update_vk
    token = @@vk.token
    index = TOKENS.index(token)
    new_token = TOKENS[index + 1]
    @@vk = VkontakteApi::Client.new(new_token)
  end

  def self.vk
    @@vk
  end

  # only for testing purposes
  def self.vk_reset
    @@vk = VkontakteApi::Client.new(TOKENS[0])
  end

  private

  def should_notify?
    return if !@record || !@record.try(:active)
    return unless valid_token? # cycled through all valid tokens
    messages = @@vk.messages.getHistory(user_id: @user_id)
    return if messages.first != 0 # user didn't get message from us yet
    true
  end

  def valid_token?
    @@vk.token.present?
  end
end
