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
      text.truncate(66).mb_chars.downcase.capitalize.to_s
    end
  end
end
