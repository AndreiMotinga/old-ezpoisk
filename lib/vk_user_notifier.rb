# sends message to vk user about listing added on his behalf
class VkUserNotifier
  # todo why use tokens as env vars?
  TOKENS = [
    ENV["VK_EZ_TOKEN"],
    ENV["VK_OLEG_TOKEN"],
    ENV["VK_ANDREI_TOKEN"]
  ].freeze

  # todo replace class var with class instance var
  @@vk = VkontakteApi::Client.new(TOKENS[0])

  def initialize(record)
    @record = record
    notify if should_notify?
  end

  def notify
    begin
      @@vk.messages.send(user_id: user_id, message: message)
      ping_ez("success", @record.show_url)
    rescue VkontakteApi::Error
      ping_ez("fail", @record.show_url)
      update_vk
      notify
    end
    send_friend_request
  end

  # only for testing purposes
  def self.vk_reset
    @@vk = VkontakteApi::Client.new(TOKENS[0])
  end

  private

  def send_friend_request
    return if Rails.env.test? # gem blows up. with no apparent reason
    status = @@vk.friends.add(user_id: user_id)
    ping_ez(status, "friend-request#{user_id}")
  end

  def update_vk
    token = @@vk.token
    index = TOKENS.index(token)
    new_token = TOKENS[index + 1]
    @@vk = VkontakteApi::Client.new(new_token)
  end

  def user_id
    @vk_user_id ||= @record.vk.gsub(/\D/, "")
  end

  def message
    SocialMessage.msg(@record)
  end

  def should_notify?
    true if @@vk.token.present? # cycled through all valid tokens
  end

  def ping_ez(status, msg)
    return if Rails.env.test?
    Ez.ping("#{@@vk.token.slice(1..5)}|#{status} - #{msg}")
  end
end
