# import posts form vk and calls listing creator to load them into db
class VkImporter
  GROUPS = [
    # { id: 20_420, topic: 3757285, model: "Job", state_id: 32, city_id: 17_880 },
    { id: 63852120, topic: 29158437, model: "Job", state_id: 32, city_id: 17_880 }
  ].freeze

  def self.import
    vk = VkontakteApi::Client.new(ENV["VK_GROUP_TOKEN"])
    GROUPS.each do |group|
      data = vk.board.getComments(group_id: group[:id],
                                  topic_id: group[:topic],
                                  sort: "desc")
      data.comments.shift # remove first element
      data.comments.each { |p| VkCreator.new(p, group) }
    end
  end
end
