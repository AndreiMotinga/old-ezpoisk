require "rails_helper"

feature "user creates service" do
  scenario "successfully", js: true do
    state = State.create(name: "Alabama")
    City.create(name: "Abbeville", state: state)
    user = create :user
    login_as(user, scope: :user)

    visit new_dashboard_service_path
    service = build(:service)

    fill_in "Название", with: service.title
    fill_in "Улица", with: service.street
    fill_in "Телефон", with: service.phone
    fill_in :Email, with: service.email
    fill_in "Сайт", with: service.site
    check("Активно?")
    select("Alabama", from: "Штат")
    select("Abbeville", from: "Город")

    click_on "details"

    expect(page).to have_content service.title
    expect(page).to have_content service.street
    expect(page).to have_content service.phone
    expect(page).to have_content service.site
    expect(page).to have_content service.email
  end
end
