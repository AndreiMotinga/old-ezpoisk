class HomeController < ApplicationController
  layout "plain"

  def index
    @listings = Listing.active.desc.limit(25)
    @answers = Answer.includes(:user).desc.limit(5)
  end
end
