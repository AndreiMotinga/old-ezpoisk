class HomeController < ApplicationController
  layout "plain"

  def index
    @listings = Listing.joins(:pictures)
                       .where(pictures: {logo: true}, listings: { active: true })
                       .order("listings.updated_at desc")
                       .limit(25)

    @answers = Answer.includes(:user).desc.limit(5)
  end
end
