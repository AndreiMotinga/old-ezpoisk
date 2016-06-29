class ReFinancesController < ApplicationController
  before_action :set_partners, only: :index

  def index
    @re_finances = Service.re_finances.filter(
      params.slice(:state_id, :city_id, :geo_scope)
    ).order("updated_at desc").page(params[:page])
  end

  private

  def set_partners
    @partner_ads = PartnerAds.new("Финансирование")
  end
end
