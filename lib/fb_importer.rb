# import posts form fb and calls listing creator to load them into db
class FbImporter
  def initialize(group)
    case group
    when "jobs" then @groups = JOBS
    when "re_privates" then @groups = RE_PRIVATES
    when "sales" then @groups = SALES
    end
  end

  def import
    graph = Koala::Facebook::API.new(ENV["FB_TOKEN"])
    @groups.each do |group|
      data = graph.get_connections(
        group[:id], "feed", fields: %w("message", "from", "attachments")
      )
      data.each_with_index { |p, i| FbCreator.new(p, group, i) }
    end
  end

  JOBS = [
    { id: 22558194, model: "Job", state_id: 32, city_id: 17880 }, # USA
  ].freeze

  RE_PRIVATES = [
    { id: 387962, topic: 27461153, model: "RePrivate", state_id: 47, city_id: 27588 },
  ].freeze

  SALES = [
    { id: 40123, topic: 22888414, model: "Sale", state_id: 9, city_id: 3964 },
  ].freeze
end
