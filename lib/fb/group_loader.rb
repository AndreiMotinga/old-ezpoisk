# frozen_string_literal: true

module Fb
  # loads posts from fb group
  class GroupLoader
    attr_reader :group, :graph

    def initialize(group)
      @graph = Koala::Facebook::API.new(ENV["FB_TOKEN"])
      @group = group
    end

    def data
      fields = %w(from message created_time attachments)
      response = graph.get_connections(group[:id], "feed", fields: fields)
      response.map! { |post| Fb::Unifier.new(post, group).unified }
    end
  end
end
