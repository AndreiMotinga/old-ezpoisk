class JobAgenciesController < ApplicationController
  # before_action :set_partners, only: :index

  def index
    @job_agencies = Service.job_agencies.filter(
      params.slice(:state_id, :city_id, :geo_scope)
    ).page(params[:page])
  end

  private

  def set_partners
    @partner_ads = PartnerAds.new("Агентства по Трудоустройству")
  end
end
