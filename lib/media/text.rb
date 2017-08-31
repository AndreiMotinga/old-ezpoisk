# frozen_string_literal: true

module Media
  # sanitizes text
  class Text
    attr_reader :text

    def self.clean(msg)
      new(msg).sanitize
    end

    def initialize(msg)
      @text = msg
    end

    def sanitize
      return "" unless text.present?
      text.gsub!(REGEX, "") # remove emojis
      text.gsub!("<br>", "\r\n")
      text.gsub!("&amp;", "&")
    end

    REGEX = /[\u{1F600}-\u{1F6FF}]/
  end
end
