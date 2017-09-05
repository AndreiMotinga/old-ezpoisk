# frozen_string_literal: true
# exports recs to vk groups

module Vk
  class Exporter
    def self.export(rec)
      new(rec).export
    end

    attr_reader :vk, :rec, :group

    def initialize(rec)
      @rec = rec
      @vk = VkontakteApi::Client.new(ENV["VK_ANDREI_TOKEN"])
    end

    def export
      begin
        vk.wall.post(owner_id: id, attachments: rec.show_url) if rec.article?
        vk.board.createComment(group_id: id, topic_id: t_id, message: msg) if rec.listing?
      rescue
        # if there is no appropriate place to send rec
        # abort and repost rec to ez
        Ez.ping "VK::Exporter error: #{rec.class} #{rec.id}"
      end
    end

    private

    def msg
      html = "#{rec.kind} | #{rec.category}\n\n"
      html += "#{rec.text}\n\n"
      html + "Подробнее #{URI.unescape rec.show_url}"
    end

    def id
      id = VK_GROUPS[rec.city_slug].try(:[], :id)
      return unless id
      rec.article? ? -id : id
    end

    def t_id
      VK_GROUPS[rec.city_slug][rec.kind]
    end
  end
end
