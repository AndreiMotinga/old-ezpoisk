module Vk
  # loads posts from vk group
  class GroupLoader
    attr_reader :group, :vk

    def initialize(group)
      @vk = VkontakteApi::Client.new
      @group = group
    end

    def data
      prms = { group_id: group[:id], topic_id: group[:topic], sort: :desc }
      response = vk.board.getComments(prms)
      response.items.map! { |post| Vk::Unifier.new(post, group).unified }
    end
  end
end
