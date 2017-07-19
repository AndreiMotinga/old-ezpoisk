require "rails_helper"

feature "User filters listings" do
  scenario "by state" do
    listing = create :listing

    visit listings_path(kind: listing.kind)
    select(listing.state.name, from: :state)
    click_on "Обновить"

    expect(page).to have_content listing.title
  end

  scenario "by kind" do
    listing = create :listing

    visit listings_path(kind: listing.kind)
    select I18n.t(listing.kind), from: :kind
    click_on "Обновить"

    expect(page).to have_content listing.title
  end

  scenario "by kind" do
    listing = create :listing

    visit listings_path(kind: listing.kind)
    select I18n.t(listing.kind), from: :kind
    click_on "Обновить"

    expect(page).to have_content listing.title
  end
end
