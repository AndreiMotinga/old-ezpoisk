class HomeController < ApplicationController
  layout :resolve_layout
  before_action :set_partners, only: [:index]

  def index
    GeolocateUserJob.perform_async(request.remote_ip)
    @homepage = Homepage.new
  end

  def about
    @feedback = Feedback.new
  end

  def htmltagstrippingtool
  end

  private

  def set_partners
    @partner_ads = PartnerAds.new("Домашняя", 1, nil, 1)
  end

  def resolve_layout
    case action_name
    when "index"
      "home"
    when "about"
      "about"
    else
      "application"
    end
  end
end
