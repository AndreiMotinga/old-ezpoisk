require "rails_helper"

feature "Browses listing" do
  scenario "when exists" do
    listing = create :listing, :apartment

    visit listing_path listing

    expect(page).to have_content listing.text
  end

  scenario "doesn't exist" do
    visit listing_path(400)

    expect(page).to have_current_path(root_path)
  end
end
