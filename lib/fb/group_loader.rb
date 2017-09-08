# frozen_string_literal: true

module Fb
  # loads posts from fb group
  class GroupLoader
    attr_reader :group, :graph

    def self.load(group)
      new(group).data
    end

    def initialize(group)
      @graph = Koala::Facebook::API.new(ENV["FB_TOKEN"])
      @group = group
    end

    def data
      begin
        fields = %w(from message created_time attachments permalink_url)
        Rails.logger.info "importing #{group['kind']} from #{group['id']}"
        response = graph.get_connections(group["id"], "feed", fields: fields)
        Rails.logger.info "imported #{response.size}"
        response.map! { |post| Fb::Unifier.unify(post, group) }
      rescue e
        Ez.ping "Fb::Importer error: #{group}"
        Ez.ping e
      end
    end
  end
end
