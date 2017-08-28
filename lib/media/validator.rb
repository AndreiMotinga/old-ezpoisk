# frozen_string_literal: true

module Media
  # validate that listing is fresh, not yet persisted etc
  class Validator
    attr_reader :attrs

    def self.valid?(attrs)
      new(attrs).valid?
    end

    def initialize(attrs)
      @attrs = attrs
    end

    BAD_WORDS = [
      # "Russian America",
      # "russian-america",
      # "ООН",
      # "Профессиональная помощь в оформление политического убежища в США!",
      # "Смотри рекламу получай деньги! 10часов=250$",
      # "ТОЛЬКО НЬЮ ЙОРК\nАНГЛИЙСКИЙ ЯЗЫК ДЛЯ ВСЕХ!!!!",
      # "Rio - это",
      # "Хороший знакомый (американец) ищет комнату",
      # "helpdetected.com",
      # "Американский визовый центр",
      # "almaz89.ilgamos.com",
      # "Billionaire.goldandcrypto.com",
      # "hrimmigration91@yahoo.com",
      # "Продаю SSN",
      # "https://crp.center",
      # "https://vk.com/englishdiscussion",
      # "АРЕНДА АВТО! ЛЕТНЯЯ АКЦИЯ!",
      # "hiringman.com"
    ].map(&:freeze).freeze

    def valid?
      return if too_old?
      return if too_short?
      return if vk_post_is_response?
      return if post_contains_bad_words?
      return if vk_post_from_user_exists?
      return if fb_post_from_user_exists?
      true
    end

    private

    def too_old?
      attrs[:created_at] < 2.hour.ago
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

    def vk_post_from_user_exists?
      vk = attrs[:vk]
      return unless vk.present?
      Listing.active.where(text: text, vk: vk).any?
    end

    def fb_post_from_user_exists?
      fb = attrs[:fb]
      return unless fb.present?
      Listing.active.where(text: text, fb: fb).any?
    end

    def text
      attrs[:text]
    end
  end
end
