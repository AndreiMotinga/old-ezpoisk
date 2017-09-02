# frozen_string_literal: true
# exports records to vk groups

module Vk
  class Exporter
    def self.export(record)
      new(record).export
    end

    attr_reader :vk, :record, :group

    def initialize(record)
      @record = record
      @group = Vk::GroupSelector.from(record)
      @vk = VkontakteApi::Client.new(ENV["VK_ANDREI_TOKEN"])
    end

    def export
      if %W(Post Answer Question).include? record.class.to_s
        vk.wall.post(owner_id: group.id, attachments: record.show_url)
      else
        vk.board.createComment(group_id: group.id,
                               topic_id: group.topic_id,
                               message: message)
      end
    end

    private

    def message
      html = "#{record.kind} | #{record.category}\n\n"
      html += "#{record.text}\n\n"
      html + "Подробнее #{URI.unescape record.show_url}"
    end
  end
end
