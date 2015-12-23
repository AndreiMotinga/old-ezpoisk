require "rails_helper"

feature "user creates re_agency" do
  scenario "successfully", js: true do
    state = State.create(name: "Alabama")
    City.create(name: "Abbeville", state: state)
    user = create :user
    login_as(user, scope: :user)

    visit new_dashboard_re_agency_path
    re_agency = build(:re_agency)
    fill_in :Title, with: re_agency.title
    fill_in :Street, with: re_agency.street
    fill_in :Phone, with: re_agency.phone
    fill_in :Email, with: re_agency.email
    fill_in :Site, with: re_agency.site
    fill_in :Description, with: re_agency.description
    check(:Active)
    select("Alabama", from: :State)
    select("Abbeville", from: :City)

    click_on "Создать Re agency"

    expect(page).to have_content re_agency.title
    expect(page).to have_content "Alabama"
  end
end
