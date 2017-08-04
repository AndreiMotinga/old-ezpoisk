require "rails_helper"

feature "User browses listings" do
  scenario "success" do
    user = create_and_login_user
    listing = create :listing, :service, user: user

    visit listings_user_path(user)

    expect(page).to have_content listing.category
  end
end
