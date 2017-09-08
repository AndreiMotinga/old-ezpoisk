# frozen_string_literal: true

module Vk
  # loads posts from vk group
  class GroupLoader
    attr_reader :group, :vk

    def self.load(group)
      new(group).data
    end

    def initialize(group)
      @group = group
      if with_token?
        @vk = VkontakteApi::Client.new(ENV["VK_ANDREI_TOKEN"])
      else
        @vk = VkontakteApi::Client.new
      end
    end

    def data
      prms = {
        group_id: group["id"],
        topic_id: group["topic"],
        sort: :desc,
        extended: 1
      }
      begin
        response = vk.board.getComments(prms)
        response.items.map do |post|
          user = response.profiles.find { |p| p.id == post.from_id }
          return nil unless user # skip ads
          Vk::Unifier.unify(post, group, user)
        end
      rescue => e
        Ez.ping "Vk::Importer error: #{group}"
        Ez.ping e
      end
    end

    def with_token?
      [52035, 2688174, 20420, 13511430, 35762330].include? group["id"]
    end
  end
end
