class HomeController < ApplicationController
  layout :resolve_layout
  before_action :set_partners, only: [:index]

  def index
    @homepage = Homepage.new
  end

  def about
    @feedback = Feedback.new
  end

  def htmltagstrippingtool
  end

  def really
    GrumpyDog.create
    @count = GrumpyDog.count
    Ez.ping("really?:  #{@count}")
  end

  private

  def set_partners
    state_id = session[:state_id]
    return if state_id == 0
    @partner_ads = PartnerAds.new(state_id, "Домашняя")
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
