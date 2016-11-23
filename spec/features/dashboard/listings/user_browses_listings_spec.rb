require "rails_helper"

feature "User browses listings" do
  scenario "success" do
    user = create_and_login_user
    listing = create :listing, user: user

    visit dashboard_listings_path

    expect(page).to have_content listing.title
  end
end
