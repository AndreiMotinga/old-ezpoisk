require "rails_helper"

feature "user updates job_agency" do
  scenario "successfully", js: true do
    create_alabama_and_abbeville
    user = create_and_login_user
    job_agency = create(:job_agency, user: user)

    visit edit_dashboard_job_agency_path job_agency
    attrs = build(:job_agency)

    fill_in "Название", with: attrs.title
    fill_in "Улица", with: attrs.street
    fill_in "Телефон", with: attrs.phone
    fill_in "Email", with: attrs.email
    fill_in "Сайт", with: attrs.site
    select("Alabama", from: "Штат")
    select("Abbeville", from: "Город")
    check("Активно")

    click_on "details-save-btn"

    expect(page).to have_content I18n.t(:post_saved)
    job_agency.reload
    expect(job_agency.street).to eq attrs.street
    expect(job_agency.phone).to eq attrs.phone
    expect(job_agency.site).to eq attrs.site
    expect(job_agency.email).to eq attrs.email
    expect(job_agency.active).to be true
    expect(job_agency.state.name).to eq "Alabama"
    expect(job_agency.city.name).to eq "Abbeville"
  end
end
