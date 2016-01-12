require "rails_helper"

feature "user creates job_agency" do
  scenario "successfully", js: true do
    create_alabama_and_abbeville
    create_and_login_user

    visit new_dashboard_job_agency_path
    job_agency = build(:job_agency)

    fill_in "Название", with: job_agency.title
    fill_in "Улица", with: job_agency.street
    fill_in "Телефон", with: job_agency.phone
    fill_in "Email", with: job_agency.email
    fill_in "Сайт", with: job_agency.site
    select("Alabama", from: "Штат")
    select("Abbeville", from: "Город")
    check("Активно?")

    click_on "Сохранить"

    expect(page).to have_content job_agency.title
    expect(page).to have_content job_agency.street
    expect(page).to have_content job_agency.phone
    expect(page).to have_content job_agency.site

    agency = JobAgency.last
    expect(agency.active).to be true
    expect(agency.state_id).to_not be nil
    expect(agency.city_id).to_not be nil
    expect(agency.user_id).to_not be nil
  end
end
