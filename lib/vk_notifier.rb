class VkNotifier
  def initialize
    @vk = VkontakteApi::Client.new(ENV["VK_GROUP_TOKEN"])
  end

  def post_to_wall(record)
    id = -ENV["VK_GROUP_ID"].to_i
    @vk.wall.post(owner_id: id, from_group: 1, attachments: record.show_url)
  end

  def post_to_topic(record)
    @vk.board.createComment(
      group_id: 112797570,
      topic_id: topic_id(record),
      from_group: 1,
      message: record.vk_message,
    )
  end

  def topic_id(record)
    case record.class.to_s
    when "RePrivate" then 33955066
    when "Job" then 33955064
    when "Sale" then 33955068
    when "Service" then 33955067
    end
  end

  def send_message(user_id, record)
    messages = @vk.messages.getHistory(user_id: user_id)
    return unless messages.first == 0 # user already got message from us
    @vk.messages.send(user_id: @author, message: SocialMessage.message(record))
  end
end
