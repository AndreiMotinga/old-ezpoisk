# prevents from creating listings that don't fit the bill.freeze
class TextChecker
  BAD_WORDS = [
    "Russian America",
    "russian-america",
    "ООН",
    "Профессиональная помощь в оформление политического убежища в США!",
    "Смотри рекламу получай деньги! 10часов=250$",
    "ТОЛЬКО НЬЮ ЙОРК\nАНГЛИЙСКИЙ ЯЗЫК ДЛЯ ВСЕХ!!!!",
    "Rio - это",
    "Хороший знакомый (американец) ищет комнату",
    "helpdetected.com",
    "hiringman.com"
  ].freeze
  private_constant :BAD_WORDS

  def initialize(model, text, vk)
    @model = model
    @text = text
    @vk = vk
  end

  def cool?
    return if post_is_response?
    return if post_already_exists?
    return if post_from_user_is_fresh?
    return if post_contains_bad_words?
    true
  end

  private

  def post_is_response?
    @text.match(/\[\w.+\]/).present?
  end

  def post_already_exists?
    @model.constantize.find_by_text(@text).present?
  end

  def post_from_user_is_fresh?
    @model.constantize.where("vk = ? AND created_at > ?", @vk, 1.day.ago).any?
  end

  def post_contains_bad_words?
    BAD_WORDS.any? { |word| @text.include?(word) }
  end
end
