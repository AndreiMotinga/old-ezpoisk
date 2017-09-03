# frozen_string_literal: true
# posts messages to facebook walls

# in order to add page
  # 1. generate page token
  # 2 add page id to FB_GROUPS in my_constants.rb
  # 3. add env variable for that page in format FB_'CITYSLUG'
# in order to add group

module Fb
  class Exporter
    def self.export(record)
      new(record).export
    end

    attr_reader :fb, :record

    def initialize(record)
      @record = record
      @fb = Koala::Facebook::API.new(ENV[token])
    end

    def export
      # if there is no appropriate place to send record
      # abort and report record to ez
      unless page && group
        Ez.ping "Fb::Exporter error: #{record.class} #{record.id}"
        return
      end
      fb.put_connections(group, "feed", link: record.show_url) if record.listing?
      fb.put_connections(page, "feed", link: record.show_url) if record.article?
    end

    def group
      groups = FB_GROUPS[record.city_slug].try(:[], :groups)
      return unless groups
      groups[record.kind]
    end

    def page
      FB_GROUPS[record.city_slug].try(:[], :page)
    end

    def token
      token = "FB_EXPORT_GROUP_TOKEN"
      token = "FB_#{record.city_slug.tr('-', '_').upcase}" if record.article?
      token
    end
  end
end
