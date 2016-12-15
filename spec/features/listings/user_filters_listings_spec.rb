require "rails_helper"

feature "User filters listings" do
  scenario "success" do
    listing = create :listing

    visit search_listings_path(kind: listing.kind)

    select(listing.state.name, from: :state)
    select I18n.t(listing.category), from: :category
    select I18n.t(listing.subcategory), from: :subcategory
    click_on "Обновить"

    expect(page).to have_content listing.title
  end
end
