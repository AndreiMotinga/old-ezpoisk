require "rails_helper"

feature "user updates re_agency" do
  scenario "successfully" do
    re_agency = create :re_agency
    user = create :user
    login_as(user, scope: :user)

    visit edit_dashboard_re_agency_path re_agency
    fill_in "Название", with: "New title"
    fill_in "Улица", with: "New street"
    fill_in "Телефон", with: "999 999 999"
    fill_in :Email, with: "some@gmail.com"
    fill_in "Сайт", with: "www.example.com"
    check("Активно?")

    click_on "details"

    expect(page).to have_content "New title"
    expect(page).to have_content "New street"
    expect(page).to have_content "999 999 999"
    expect(page).to have_content "some@gmail.com"
  end
end
