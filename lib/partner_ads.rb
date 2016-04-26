class PartnerAds
  attr_reader :top, :side, :bottom

  def initialize(state_id, page)
    @state_id = state_id
    @page ||= page
    @top ||= partner_for("Вверху")
    @side ||= partner_for("Справа")
    @bottom ||= partner_for("Внизу")
  end

  def partner_for(position)
    Partner.current(@state_id, @page, position)
  end
end
