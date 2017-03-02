class HomeController < ApplicationController
  def index
    @listings = Listing.joins(:pictures)
                       .where(pictures: {logo: true}, listings: { active: true })
                       .order("listings.updated_at desc")
                       .limit(16)

    @answers = Answer.includes(:user).desc.limit(5)
  end

  def cert
    render text: 'Kxaxwygc2ucTLW2-D3TF3wM5XHi6OQ9X_nhloCkhilc.b1PiULHHoNe11AhEMh8b1ItLr7bUVus_Xl3SSMee7O4'
  end
end
