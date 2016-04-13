require "rails_helper"

feature "Home page" do
  scenario "user visits home page" do
    create :post
    visit root_path

    expect(page).to have_content "Услуги"
    expect(page).to have_content "Недвижимость"
  end
end
