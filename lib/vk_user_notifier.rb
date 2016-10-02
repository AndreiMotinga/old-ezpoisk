# manually via heroku restart
# run a bg job once 12? hours to call VkUserNotifier.vk_reset
# every time you tun importer, reset it beforehand

# sends message to vk user about listing added on his behalf
class VkUserNotifier
  TOKENS = [
    ENV["VK_ANDREI_TOKEN"],
    ENV["VK_TITOV_TOKEN"],
    ENV["VK_OLEG_TOKEN"]
  ].freeze

  @@vk = VkontakteApi::Client.new(TOKENS[0])

  def initialize(record)
    @record = record
    @user_id = vk_user_id
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

  def vk_user_id
    return "" unless @record
    @record.vk.gsub(/\D/, "")
  end

  def should_notify?
    return unless @@vk.token.present? # cycled through all valid tokens
    messages = @@vk.messages.getHistory(user_id: @user_id)
    return if messages.first != 0 # user didn't get message from us yet
    true
  end
end
