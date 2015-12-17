require 'rails_helper'

feature "User visits dashboard" do
  scenario "when logged in" do
    visit dashboard_path
    expect(page).to have_content "Панель управления"
  end
end
