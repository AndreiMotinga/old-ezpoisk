class HomeController < ApplicationController
  # before_action :set_partners, only: [:index]

  def index
    @posts = Post.includes(user: :profile)
                 .visible
                 .desc
                 .page(params[:page]).per(10)
  end

  private

  # def set_partners
  #   @partner_ads = PartnerAds.new("Домашняя")
  # end
end
