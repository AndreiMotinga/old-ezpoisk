# increments impressions_count on Partners
class PartnerImpressionsJob
  include Sidekiq::Worker

  def perform(ids)
    partners = Partner.where(id: ids)
    partners.each do |partner|
      partner.update_column(:impressions_count, partner.impressions_count + 1)
    end
  end
end
