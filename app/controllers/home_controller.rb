class HomeController < ApplicationController
  before_action :set_partners, only: [:index]

  def index
    @listings = Homepage.users_activity(20)
  end

  private

  def set_partners
    @partner_ads = PartnerAds.new("Домашняя")
  end
end
