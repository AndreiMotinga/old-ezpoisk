# import posts form vk and calls listing creator to load them into db
class VkImporter
  GROUPS = [
    { id: 35762330, topic: 34071351, model: "Job", category: "seeking", state_id: 32, city_id: 18031 }, # brooklyn
    { id: 35762330, topic: 26705408, model: "Job", category: "wanted", state_id: 32, city_id: 18031 },
    { id: 35762330, topic: 29415801, model: "Job", category: "seeking", state_id: 32, city_id: 18031 },
    { id: 2688174, topic: 26691681, model: "Job", category: "wanted", state_id: 32, city_id: 17880 }, # new york
    { id: 12885141, topic: 30593895, model: "Job", category: "wanted", state_id: 32, city_id: 17880 },
    { id: 20420, topic: 3757285, model: "Job", category: "wanted", state_id: 32, city_id: 17880 },
    { id: 26834667, topic: 28806915, model: "Job", category: "wanted", state_id: 32, city_id: 17880 },
    { id: 13511430, topic: 22072755, model: "Job", category: "wanted", state_id: 32, city_id: 17880 },
    { id: 10519422, topic: 31062964, model: "Job", category: "wanted", state_id: 32, city_id: 17880 },
    { id: 5891839, topic: 23250392, model: "Job", category: "wanted", state_id: 32, city_id: 17880 },
    { id: 63852120, topic: 29158437, model: "Job", category: "wanted", state_id: 9, city_id: 3964 }, # miami
    { id: 40123, topic: 5173038, model: "Job", category: "wanted", state_id: 9, city_id: 3964 },
    { id: 12971907, topic: 21841852, model: "Job", category: "wanted", state_id: 9, city_id: 3964 },
    { id: 12971907, topic: 36045928, model: "Job", category: "seeking", state_id: 9, city_id: 3964 },
    { id: 7661136, topic: 32577617, model: "Job", category: "wanted", state_id: 5, city_id: 1685 }, # LA
    { id: 94076941, topic: 32175819, model: "Job", category: "wanted", state_id: 5, city_id: 1685 }, # LA
    { id: 453825, topic: 20036943, model: "Job", category: "wanted", state_id: 5, city_id: 1685 }, # LA
    { id: 13509936, topic: 24726611, model: "Job", category: "wanted", state_id: 5, city_id: 1685 }, # LA
    { id: 22558194, topic: 24112410, model: "Job", category: "wanted", state_id: 32, city_id: 17880 }, # USA
    { id: 22558194, topic: 26241726, model: "Job", category: "wanted", state_id: 32, city_id: 17880 }, # USA
    { id: 13457639, topic: 22345994, model: "Job", category: "wanted", state_id: 21, city_id: 10383 }, # Boston
    { id: 13509700, topic: 23277570, model: "Job", category: "wanted", state_id: 43, city_id: 25336 }, # Houston
    { id: 13247283, topic: 22522116, model: "Job", category: "wanted", state_id: 13, city_id: 6254 }, # Chicago
    { id: 11710820, topic: 23839499, model: "Job", category: "wanted", state_id: 51, city_id: 29723 }, # Washington DC
    { id: 387962, topic: 23983429, model: "Job", category: "wanted", state_id: 47, city_id: 27588 }, # Washington
  ].freeze

  def self.import
    vk = VkontakteApi::Client.new(ENV["VK_YURA_TOKEN"])
    GROUPS.each do |group|
      data = vk.board.getComments(group_id: group[:id],
                                  topic_id: group[:topic],
                                  sort: "desc")
      data.comments.shift # remove first element
      data.comments.each { |p| VkCreator.new(p, group) }
    end
  end
end
