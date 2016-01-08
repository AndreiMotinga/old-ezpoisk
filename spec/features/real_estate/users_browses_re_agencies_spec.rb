require "rails_helper"

feature "User browses re_agencies" do
  scenario "success" do
    visit real_estate_re_agencies_path
    expect(page).to have_content("Расширенный поиск")
  end
end
