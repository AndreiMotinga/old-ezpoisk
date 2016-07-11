class HomeController < ApplicationController
  # before_action :set_partners, only: [:index]

  def index
    @entries = Entry.includes(enterable: :user)
                    .order("updated_at desc")
                    .page(params[:page])
  end

  private

  # def set_partners
  #   @partner_ads = PartnerAds.new("Домашняя")
  # end
end
