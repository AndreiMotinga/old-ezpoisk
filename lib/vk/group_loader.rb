# frozen_string_literal: true

module Vk
  # loads posts from vk group
  class GroupLoader
    attr_reader :group, :vk

    def initialize(group)
      @vk = VkontakteApi::Client.new
      @group = group
    end

    def data
      prms = {
        group_id: group[:id],
        topic_id: group[:topic],
        sort: :desc,
        extended: 1
      }
      response = vk.board.getComments(prms)
      response.items.map! do |post|
        user = response.profiles.find { |p| p.id == post.from_id }
        Vk::Unifier.new(post, group, user).unified
      end
    end
  end
end
