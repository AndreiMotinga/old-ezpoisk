require "rails_helper"

RSpec.describe "Favorites" do
  it "renders index" do
    user = create_and_login_user
    listing = create :listing
    create :favorite, favorable: listing, user: user, saved: true

    get "/dashboard/favorites"

    expect(response).to render_template(:index)
    expect(response.body).to include(listing.title)
  end
end
