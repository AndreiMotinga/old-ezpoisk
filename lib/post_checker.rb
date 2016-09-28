# prevents from creating listings that don't fit the bill.freeze
class PostChecker
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

  def initialize(model, post)
    @model = model
    @text = post[:text]
    @vk = post[:vk]
    @fb = post[:fb]
  end

  def cool?
    return if too_short?
    return if vk_post_is_response?
    return if post_contains_bad_words?
    return if vk_post_from_user_is_fresh?
    return if fb_post_from_user_is_fresh?
    return if post_already_exists?
    true
  end

  private

  def too_short?
    @text.size < 10
  end

  def vk_post_is_response?
    @text.match(/\[\w.+\]/).present?
  end

  def post_contains_bad_words?
    BAD_WORDS.any? { |word| @text.include?(word) }
  end

  def vk_post_from_user_is_fresh?
    return unless @vk.present?
    @model.constantize.where("vk = ? AND created_at > ?", @vk, 1.day.ago).any?
  end

  def fb_post_from_user_is_fresh?
    return unless @fb.present?
    @model.constantize.where("fb = ? AND created_at > ?", @fb, 1.day.ago).any?
  end

  def post_already_exists?
    @model.constantize.find_by_text(@text).present?
  end
end
