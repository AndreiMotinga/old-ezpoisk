class PartnerAdsReset
  def initialize
    Partner.find_each do |p|
      p.current_balance = 0
      p.impressions_count = 0
      p.save
    end
  end
end
