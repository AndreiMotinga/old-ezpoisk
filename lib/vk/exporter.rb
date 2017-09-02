# frozen_string_literal: true
# exports records to vk groups

module Vk
  class Exporter
    def self.export(record)
      new(record).export
    end

    attr_reader :vk, :record

    def initialize(record)
      @record = record
      @vk = VkontakteApi::Client.new(ENV["VK_ANDREI_TOKEN"])
    end

    def export
      if %W(Post Answer).include? record.class.to_s
        vk.wall.post(owner_id: id, attachments: record.show_url)
      else
        vk.board.createComment(group_id: id,
                               topic_id: topic,
                               message: record.vk_message)
      end
    end

    private

    def id
      VK_GROUPS[record.city.name][:id]
    end

    def topic
      VK_GROUPS[record.city.name][record.kind]
    end
  end
end
