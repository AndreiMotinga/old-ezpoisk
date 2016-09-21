# increments impressions_count on Partners
class PartnerImpressionsJob
  include Sidekiq::Worker

  def perform(id)
    partner = Partner.find(id)
    return unless partner
    partner.update_column(:impressions_count, partner.impressions_count + 1)
  end
end
