# frozen_string_literal: true

# creates impression
class ImpressionableJob
  include Sidekiq::Worker
  sidekiq_options queue: "low"

  def perform(type, id, kind, user_id, ip_address, referrer)
    record = type.constantize.find_by_id(id)
    return unless record
    record.impressions.create(kind: kind,
                              user_id: user_id,
                              ip_address: ip_address,
                              referrer: referrer)
    record.update_column(:cached_ctr, record.ctr) if type == "Partner"
  end
end
