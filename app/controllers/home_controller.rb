class HomeController < ApplicationController
  # before_action :set_partners, only: [:index]

  def index
    # todo only select name and avatar
    @posts = Post.includes(:user)
                 .visible
                 .desc
                 .page(params[:page]).per(10)
  end

  def about
  end

  private

  # def set_partners
  #   @partner_ads = PartnerAds.new("Домашняя")
  # end
end
