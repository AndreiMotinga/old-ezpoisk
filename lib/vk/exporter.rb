module Vk
  # sends listings to vk
  class Exporter
    def initialize(id, model)
      @record = model.constantize.find_by_id(id)
      return unless @record && @record.active
      @vk = VkontakteApi::Client.new(ENV["VK_ANDREI_TOKEN"])
      send_notification
    end

    def send_notification
      model = @record.class.to_s
      if model == "Post" || model == "Answer"
        post_to_wall
      else
        post_to_topic
      end
    end

    def post_to_wall
      id = -ENV["VK_GROUP_ID"].to_i
      @vk.wall.post(owner_id: id, from_group: 1, attachments: @record.show_url)
    end

    def post_to_topic
      @vk.board.createComment(
        group_id: 112_797_570,
        topic_id: topic_id,
        from_group: 1,
        message: @record.vk_message
      )
    end

    def topic_id
      case @record.class.to_s
      when "RePrivate" then 339_550_66
      when "Job" then 339_550_64
      when "Sale" then 339_550_68
      when "Service" then 339_550_67
      end
    end
  end
end
