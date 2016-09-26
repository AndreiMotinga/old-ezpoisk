class TextChecker
  def initialize(text, model)
    @text = text
    @model = model
  end

  def is_cool?
    return false if post_is_response?
    return false if post_already_exists?
    return false if post_from_user_is_fresh?
    return false if post_contains_bad_words?
    true
  end

  def post_is_response?
    @text.match(/\[\w.+\]/).present?
  end

  def post_already_exists?
    @model.constantize.find_by_text(@text)
  end

  def post_from_user_is_fresh?
    record = @model.constantize.find_by_vk(@vk)
    return true if record.try(:fresh?)
  end

  def post_contains_bad_words?
    match = false
    BAD_WORDS.each { |w| match = true if  @text.match(/#{w}/i).present? }
    match
  end

  BAD_WORDS = [
    "Russian America",
    "russian-america",
    "ООН",
    "Профессиональная помощь в оформление политического убежища в США!",
    "Смотри рекламу получай деньги! 10часов=250$",
    "ТОЛЬКО НЬЮ ЙОРК\nАНГЛИЙСКИЙ ЯЗЫК ДЛЯ ВСЕХ!!!!"
  ]
end
