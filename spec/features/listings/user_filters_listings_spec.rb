require "rails_helper"

feature "User filters listings" do
  scenario "by state" do
    listing = create :listing, :service

    visit listings_path(kind: listing.kind)
    select(listing.state.name, from: :state)
    click_on "Обновить"

    expect(page).to have_content listing.title
  end
end
