class ReAgenciesController < ApplicationController
  # before_action :set_partners, only: :index

  def index
    @re_agencies = Service.re_agencies
                          .includes(:state, :city)
                          .filter(params.slice(:state_id, :city_id, :geo_scope))
                          .page(params[:page])
  end

  private

  def set_partners
    @partner_ads = PartnerAds.new("Агентства Недвижимости")
  end
end
