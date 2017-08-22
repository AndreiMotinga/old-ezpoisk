require "rails_helper"
include FormHelper

feature "User" do
  scenario "browses listings by kind" do
    listing = create :listing
    dummy = create :listing, kind: (RU_KINDS.keys - [listing.kind]).sample

    visit search_listings_path(kind: listing.kind)

    prm = listing.kind == "услуги" ? :title : :text
    expect(page).to have_content listing.send(prm)
    expect(page).to_not have_content dummy.send(prm)
  end

  scenario "browses listings by state" do
    listing = create :listing, :in_brooklyn
    dummy = create :listing, :in_miami, kind: listing.kind

    visit search_listings_path(kind: listing.kind)
    select("New York", from: "state")
    click_on "Обновить"

    prm = listing.kind == "услуги" ? :title : :text
    expect(page).to have_content listing.send(prm)
    expect(page).to_not have_content dummy.send(prm)
  end

  scenario "browses listings by city", js: true do
    listing = create :listing, :in_brooklyn
    dummy = create :listing, :in_miami, kind: listing.kind

    visit search_listings_path(kind: listing.kind)
    select("New York", from: "state")
    select("Brooklyn", from: "city")
    click_on "Обновить"

    prm = listing.kind == "услуги" ? :title : :text
    expect(page).to have_content listing.send(prm)
    expect(page).to_not have_content dummy.send(prm)
  end

  scenario "browses listings by category" do
    listing = create :listing
    category = display(listing.category)

    visit search_listings_path(kind: listing.kind)
    select(category, from: "category")
    click_on "Обновить"

    prm = listing.kind == "услуги" ? :title : :text
    expect(page).to have_content listing.send(prm)
  end

  scenario "browses listings by subcategory", js: true do
    listing = create :listing
    category = display(listing.category)
    subcategory = display(listing.subcategory)

    visit search_listings_path(kind: listing.kind)
    select(category, from: "category")
    select(subcategory, from: "subcategory")
    click_on "Обновить"

    prm = listing.kind == "услуги" ? :title : :text
    expect(page).to have_content listing.send(prm)
  end
end
