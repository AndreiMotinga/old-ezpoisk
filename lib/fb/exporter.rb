module Fb
  # posts messages to facebook walls
  class Exporter
    def self.post(record)
      page = record.class.to_s.upcase
      id = ENV["FB_EZ_#{page}_ID"]
      token = ENV["FB_EZ_#{page}_TOKEN"]
      graph = Koala::Facebook::API.new(token)
      graph.put_connections(id, "feed", link: record.show_url)
    end
  end
end
