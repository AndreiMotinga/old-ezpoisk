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
      if %W(Post Answer Question).include? record.class.to_s
        vk.wall.post(owner_id: tag_id, attachments: record.show_url)
      else
        vk.board.createComment(group_id: id,
                               topic_id: topic,
                               message: message)
      end
    end

    private

    def tag_id
      city_tags = ["new-york", "los-angeles", "san-francisco"]
      slug = (city_tags & record.tag_list).first
      id = VK_GROUPS[slug][:id]
      -id
    end

    def id
      VK_GROUPS[record.city.slug][:id]
    end

    def topic
      VK_GROUPS[record.city.slug][record.kind]
    end

    def message
      html = "#{record.kind} | #{record.category}\n\n"
      html += "#{record.text}\n\n"
      html + "Подробнее #{URI.unescape record.show_url}"
    end
  end
end
