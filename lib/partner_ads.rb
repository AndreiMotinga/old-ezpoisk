class PartnerAds
  attr_reader :top, :side, :bottom

  def initialize(page)
    @page ||= page
    @top ||= partner_for("Вверху")
    @side ||= partner_for("Справа")
    @bottom ||= partner_for("Внизу")
  end

  def partner_for(position)
    Partner.current(@page, position)
  end
end
