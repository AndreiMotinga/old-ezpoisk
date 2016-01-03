require "rails_helper"

feature "user creates re_agency" do
  scenario "successfully", js: true do
    state = State.create(name: "Alabama")
    City.create(name: "Abbeville", state: state)
    user = create :user
    login_as(user, scope: :user)

    visit new_dashboard_re_agency_path
    re_agency = build(:re_agency)

    fill_in "Название", with: re_agency.title
    fill_in "Улица", with: re_agency.street
    fill_in "Телефон", with: re_agency.phone
    fill_in :Email, with: re_agency.email
    fill_in "Сайт", with: re_agency.site
    check("Активно?")
    select("Alabama", from: "Штат")
    select("Abbeville", from: "Город")

    click_on "details"

    expect(page).to have_content re_agency.title
    expect(page).to have_content re_agency.street
    expect(page).to have_content re_agency.phone
    expect(page).to have_content re_agency.site
    expect(page).to have_content re_agency.email
  end
end
