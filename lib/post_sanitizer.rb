class PostSanitizer
  def initialize(text)
    @text = text
  end

  def clean
    return "" unless @text.present?
    @text.gsub("<br>", "\n").gsub(/[\u{1F600}-\u{1F6FF}]/, "") # remove emojis
  end
end
