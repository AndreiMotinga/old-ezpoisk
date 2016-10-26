module Media
  # validate that listing is fresh, not yet persisted etc
  class Validator
    attr_reader :post

    def initialize(post)
      @post = post
    end

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
      "hrimmigration91@yahoo.com",
      "Продаю SSN",
      "https://crp.center",
      "https://vk.com/englishdiscussion",
      "АРЕНДА АВТО! ЛЕТНЯЯ АКЦИЯ!",
      "hiringman.com"
    ].map(&:freeze).freeze

    def valid?
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
      post[:date] < 1.hour.ago
    end

    def too_short?
      text.size < 10
    end

    def vk_post_is_response?
      text.match(/\[\w.+\]/).present?
    end

    def post_contains_bad_words?
      BAD_WORDS.any? { |word| text.include?(word) }
    end

    def vk_post_from_user_is_fresh?
      return unless vk.present?
      model.where("vk = ? AND created_at > ?", vk, 1.week.ago).any?
    end

    def fb_post_from_user_is_fresh?
      return unless fb.present?
      model.where("fb = ? AND created_at > ?", fb, 1.week.ago).any?
    end

    def post_already_exists?
      model.where("text = ? AND created_at > ?", text, 1.week.ago).any?
    end

    def model
      @model ||= post[:model].constantize
    end

    def vk
      @vk ||= post[:vk]
    end

    def fb
      @fb ||= post[:fb]
    end

    def text
      post[:text]
    end
  end
end
