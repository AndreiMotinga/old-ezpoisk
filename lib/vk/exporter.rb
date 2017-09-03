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
      @vk = VkontakteApi::Client.new(ENV["VK_ANDREI_TOKEN"])
    end

    def export
      # if there is no appropriate place to send record
      # abort and repost record to ez
      unless id
        Ez.ping "VK::Exporter error: #{record.class} #{record.id}"
        return
      end

      vk.wall.post(owner_id: id, attachments: record.show_url) if record.article?
      if record.listing?
        vk.board.createComment(group_id: id,
                               topic_id: topic_id,
                               message: message)
      end
    end

    private

    def message
      html = "#{record.kind} | #{record.category}\n\n"
      html += "#{record.text}\n\n"
      html + "Подробнее #{URI.unescape record.show_url}"
    end

    def id
      id = VK_GROUPS[record.city_slug].try(:[], :id)
      return unless id
      record.article? ? -id : id
    end

    def topic_id
      VK_GROUPS[record.city_slug][record.kind]
    end
  end
end
