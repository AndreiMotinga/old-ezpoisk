require "rails_helper"

feature "user destroys listing" do
  scenario "successfully" do
    user = create_and_login_user
    record = create :listing, user: user

    visit edit_dashboard_listing_path record

    click_on "Удалить"

    expect(page).to have_content I18n.t(:post_removed)
    expect(Listing.count).to eq 0
  end
end
