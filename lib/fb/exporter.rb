# frozen_string_literal: true
# posts messages to facebook walls

module Fb
  class Exporter
    def self.export(record)
      new(record).export
    end

    attr_reader :graph, :record

    def initialize(record)
      @record = record
      @graph = Koala::Facebook::API.new(ENV["FB_TOKEN"])
    end

    def export
      graph.put_connections(group_id, "feed", link: record.show_url)
      # graph.put_connections(page_id, "feed", link: record.show_url)
    end

    private

    def group_id
      FB_GROUPS[city][:groups][topic]
    end

    def page_id
      FB_GROUPS[city][:pages][topic]
    end

    def topic
      article? ? "информация" : record.kind
    end

    def city
      article? ? (CITY_TAGS & record.tag_list).first : record.city.slug
    end

    def article?
      %W(Post Answer Question).include?(record.class.to_s)
    end
  end
end
