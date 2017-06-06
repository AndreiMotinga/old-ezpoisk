class HomeController < ApplicationController
  def index
    # @listings = Listing.joins(:pictures)
    #                    .where(pictures: {logo: true}, listings: { active: true })
    #                    .order("listings.updated_at desc")
    #                    .limit(16)
    #
    # @answers = Answer.includes(:user).desc.limit(5)
  end
end
