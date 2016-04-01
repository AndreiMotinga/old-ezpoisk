class PartnerAds
  attr_reader :top, :side, :bottom

  def initialize(page, session)
    @state_id = session[:state_id]
    @city_id = session[:city_id]
    @page ||= page
    @top ||= partner_for(:top)
    @side ||= partner_for(:side)
    @bottom ||= partner_for(:bottom)
  end

  def partner_for(position)
    partner = Partner.filter(position, @page, @state_id, @city_id).first
    return unless partner
    # charge(partner, position)
    increase_imressions(partner)
    partner
  end

  private

  def increase_imressions(partner)
    partner.increment!(:impressions_count)
  end
  #
  # def charge(partner, position)
  #   second_partner = Partner.filter(position, @page).second
  #   amount = amount_to_charge(partner, second_partner)
  #   partner.increment!(:current_balance, amount)
  # end

  # def amount_to_charge(partner, second_partner)
  #   return 1 unless second_partner
  #   return partner.bid if partner.bid == second_partner.bid
  #   second_partner.bid + 1
  # end
end
