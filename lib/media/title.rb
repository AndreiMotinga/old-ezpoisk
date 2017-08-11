# frozen_string_literal: true

module Media
  # set title
  class Title
    attr_reader :text

    def self.of(text)
      new(text).call
    end

    def initialize(text)
      @text = text
    end

    def call
      return "" if text.blank?
      text.truncate(66).downcase!.capitalize!
    end
  end
end
