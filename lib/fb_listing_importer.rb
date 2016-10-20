# import posts form fb and calls listing creator to load them into db
class FbListingImporter
  def self.import
    graph = Koala::Facebook::API.new(ENV["FB_TOKEN"])
    GROUPS.each do |group|
      data = graph.get_connections(group[:id], "feed", fields: %w(from message created_time attachments))
      fresh(data).each_with_index do |post, i|
        delay = 1.minute + i*20.seconds
        record = FbListingUnifier.new(post).post
        SocialListingCreatorJob.perform_in(delay, record, group)
      end
    end
  end

  def self.fresh(data)
    return data if data.empty?
    data.select { |item| item["created_time"] > 1.hour.ago }
  end

  GROUPS = [
    { id: 473109486227904, model: "Job", state_id: 32, city_id: 17880 },
    { id: 1030398037015054, model: "Job", state_id: 32, city_id: 17880 },
    { id: 137863963079459, model: "Job", state_id: 9, city_id: 3964 }, # miami
    { id: 778710555550702, model: "Job", state_id: 9, city_id: 3964 },
    { id: 323815354415874, model: "Job", state_id: 9, city_id: 3917 }, # orlando
    { id: 249106225164786, model: "Job", state_id: 5, city_id: 2302 }, # SF
    { id: 926513640746980, model: "Job", state_id: 5, city_id: 1685 }, # LA
    { id: 1609170409313852, model: "Job", state_id: 5, city_id: 1884 }, # SD
    { id: 1400977150209237, model: "Job", state_id: 47, city_id: 27588 }, # Seattle
    { id: 1106107669412708, model: "Job", state_id: 43, city_id: 24757 }, # dallas
    { id: 398984013638015, model: "Job", state_id: 3, city_id: 1416 }, # poenix
    { id: 916738071690195, model: "Job", state_id: 51, city_id: 29723 }, # DC
    { id: 118841781880515, model: "Job", state_id: 5, city_id: 2303 },

  # RE_PRIVATES
    { id: 374704915873674, model: "RePrivate", state_id: 32, city_id: 17880 },
    { id: 234474186756047, model: "RePrivate", state_id: 9, city_id: 3964 }, #miami
    { id: 897633366949647, model: "Job", state_id: 9, city_id: 3964 },
    { id: 1444506849104060, model: "RePrivate", state_id: 5, city_id: 2302 }, # SF
    { id: 157972304548564, model: "RePrivate", state_id: 5, city_id: 1685 }, #la
    { id: 925575417479962, model: "RePrivate", state_id: 5, city_id: 1884 }, #san diego
    { id: 1173206122714034, model: "RePrivate", state_id: 47, city_id: 27588 }, #seattle
    { id: 1614363378884490, model: "RePrivate", state_id: 43, city_id: 24757 }, #dallas
  ].freeze

  # SALES = [
  #   # { id: 40123, topic: 22888414, model: "Sale", state_id: 9, city_id: 3964 },
  # ].freeze
end
