require "rails_helper"

feature "User browses listings" do
  scenario "success" do
    user = create_and_login_user
    listing = create :listing, :service, user: user

    visit listings_profile_path(user)

    expect(page).to have_content listing.title
  end
end
