require "rails_helper"

feature "user creates re_agency" do
  scenario "successfully", js: true do
    create_alabama_and_abbeville
    create_and_login_user

    visit new_dashboard_re_agency_path
    re_agency = build(:re_agency)

    fill_in "Название", with: re_agency.title
    fill_in "Улица", with: re_agency.street
    fill_in "Телефон", with: re_agency.phone
    fill_in "Email", with: re_agency.email
    fill_in "Сайт", with: re_agency.site
    select("Alabama", from: "Штат")
    select("Abbeville", from: "Город")
    check("Активно")

    click_on "Сохранить"

    expect(page).to have_content re_agency.title
    expect(page).to have_content re_agency.phone
    expect(page).to have_content re_agency.site

    agency = ReAgency.last
    expect(agency.active).to be true
    expect(agency.state_id).to_not be nil
    expect(agency.city_id).to_not be nil
    expect(agency.user_id).to_not be nil
  end
end
