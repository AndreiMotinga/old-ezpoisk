class HomeController < ApplicationController
  layout :resolve_layout
  before_action :set_partners, only: [:index]

  def index
    @homepage = Homepage.new
  end

  def about
    @feedback = Feedback.new
  end

  def really
    GrumpyDog.create
    @count = GrumpyDog.count
    Ez.ping("really?:  #{@count}")
  end

  private

  def set_partners
    @partner_ads = PartnerAds.new("Домашняя")
  end

  def resolve_layout
    action_name == "index" ? "home" : "about"
  end
end
