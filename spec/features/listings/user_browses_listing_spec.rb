require "rails_helper"

feature "Browses listing" do
  scenario "when exists" do
    listing = create :listing, :apartment

    visit listing_path listing

    expect(page).to have_content listing.text
  end
end
