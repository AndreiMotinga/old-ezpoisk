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
      id = VK_GROUPS[group][:id]
      article? ? -id : id
    end

    def topic_id
      VK_GROUPS[group][record.kind]
    end

    private

    def group
      return "new-york" if state_id == 32
      return "miami" if state_id == 9
      slug
    end

    def state_id
      return record.state_id unless article?
      City.where(slug: record.tag_list).first.state_id
    end

    def slug
      return record.city.slug unless article?
      City.where(slug: record.tag_list).first.slug
    end

    def article?
      ARTICLES.include?(record.class.to_s)
    end
  end
end
