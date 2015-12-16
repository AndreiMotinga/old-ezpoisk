require "rails_helper"

feature "Home page" do
  scenario "user visits home page" do
    visit root_path

    expect(page).to have_content "CHOGDE"
  end
end
