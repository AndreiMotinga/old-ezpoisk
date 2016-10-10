# manually via heroku restart
# run a bg job once 12? hours to call VkUserNotifier.vk_reset
# every time you tun importer, reset it beforehand

# sends message to vk user about listing added on his behalf
class VkUserNotifier
  TOKENS = [
    ENV["VK_EZ_TOKEN"],
    ENV["VK_OLEG_TOKEN"],
    ENV["VK_ANDREI_TOKEN"]
  ].freeze

  @@vk = VkontakteApi::Client.new(TOKENS[0])

  def initialize(record)
    @record = record
    @user_id = vk_user_id
  end

  def notify
    return unless should_notify?
    begin
      @@vk.messages.send(user_id: @user_id, message: SocialMessage.msg(@record))
      Ez.ping("Successfully notified about #{@record.show_url}") unless Rails.env.test?
    rescue VkontakteApi::Error
      Ez.ping("Failed to notify about #{@record.show_url}") unless Rails.env.test?
      update_vk
      notify
    end
    send_friend_request
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
    true if @@vk.token.present? # cycled through all valid tokens
  end

  def send_friend_request
    # todo write test for it
    unless Rails.env.test?
      friend = @@vk.users.add(user_id: @user_id)
      Ez.ping("Successfully sent friend request to #{@user_id}") if friend == 1
      Ez.ping("Already freinds") if friend == 2
    end
  end

  # def message
  #   messages = @@vk.messages.getHistory(user_id: @user_id)
  #   if messages.first == 0 # user didn't get message from us yet
  #     SocialMessage.first_msg(@record)
  #   else
  #     SocialMessage.subsequent_msg(@record)
  #   end
  # end
end
