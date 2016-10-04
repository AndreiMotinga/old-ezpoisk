# increments impressions_count on Partners
class PartnerImpressionsJob
  include Sidekiq::Worker

  def perform(ids)
    partners = Partner.where(id: ids)
    partners.each do |partner|
      partner.increment!(:impressions_count)
    end
  end
end
