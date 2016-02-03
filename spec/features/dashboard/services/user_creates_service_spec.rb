require "rails_helper"

feature "user creates service" do
  scenario "successfully", js: true do
    create_alabama_and_abbeville
    create_and_login_user
    service = build(:service)

    visit new_dashboard_service_path
    fill_in "Заголовок", with: service.title
    fill_in "Улица", with: service.street
    fill_in "Телефон", with: service.phone
    fill_in "Email", with: service.email
    fill_in "Сайт", with: service.site
    fill_in "Подпись", with: service.slug
    select(service.category, from: "Раздел")
    select(service.subcategory, from: "Категория")
    select("Alabama", from: "Штат")
    select("Abbeville", from: "Город")
    check("Активно?")
    click_on "details-save-btn"

    expect(page).to have_content service.title
    expect(page).to have_content service.phone
    expect(page).to have_content service.site

    record = Service.last
    expect(record.active).to be true
    expect(record.category).to eq service.category
    expect(record.subcategory).to eq service.subcategory
    expect(record.slug).to eq service.slug
    expect(record.state.name).to eq "Alabama"
    expect(record.city.name).to eq "Abbeville"
    expect(record.user_id).to_not be nil
  end
end
