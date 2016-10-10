class TitleFromText
  def self.get(text)
    s = ActionView::Base.full_sanitizer.sanitize(text).slice(0, 48)
    s + "...".mb_chars.downcase.capitalize.strip.to_s
  end
end
