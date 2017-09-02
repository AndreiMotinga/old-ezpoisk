# frozen_string_literal: true

module Vk
  # retrieves group and topic to send record based on the record
  class GroupSelector
    ARTICLES = %W(Answer Question Post)

    def self.from(record)
      new(record)
    end

    attr_reader :record

    def initialize(record)
      @record = record
    end

    def id
      id = VK_GROUPS[slug][:id]
      article? ? -id : id
    end

    def topic_id
      VK_GROUPS[slug][record.kind]
    end

    private

    def slug
      article? ? (CITY_TAGS & record.tag_list).first : city_slug
    end

    def city_slug
      record.city.slug
    end

    def article?
      ARTICLES.include?(record.class.to_s)
    end
  end
end
