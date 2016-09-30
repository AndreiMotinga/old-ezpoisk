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
    "Американский визовый центр",
    "almaz89.ilgamos.com",
    "Billionaire.goldandcrypto.com",
    "hiringman.com"
  ].freeze
  private_constant :BAD_WORDS

  def initialize(model, post)
    @model = model
    @post = post
  end

  def cool?
    return if too_old?
    return if too_short?
    return if vk_post_is_response?
    return if post_contains_bad_words?
    return if vk_post_from_user_is_fresh?
    return if fb_post_from_user_is_fresh?
    return if post_already_exists?
    true
  end

  private

  def too_old?
    @post[:date] < 7.days.ago
  end

  def too_short?
    @post[:text].size < 10
  end

  def vk_post_is_response?
    @post[:text].match(/\[\w.+\]/).present?
  end

  def post_contains_bad_words?
    BAD_WORDS.any? { |word| @post[:text].include?(word) }
  end

  def vk_post_from_user_is_fresh?
    return unless @post[:vk].present?
    @model.constantize
          .where("vk = ? AND created_at > ?", @post[:vk], 1.day.ago).any?
  end

  def fb_post_from_user_is_fresh?
    return unless @post[:fb].present?
    @model.constantize
          .where("fb = ? AND created_at > ?", @post[:fb], 1.day.ago).any?
  end

  def post_already_exists?
    @model.constantize.find_by_text(@post[:text]).present?
  end
end
