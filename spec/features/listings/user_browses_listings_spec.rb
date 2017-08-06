require "rails_helper"

feature "User" do
  scenario "browses listings by kind", js: true do
    listing = create :listing, :apartment

    visit search_listings_path(kind: listing.kind)

    expect(page).to have_content listing.text
  end
end
