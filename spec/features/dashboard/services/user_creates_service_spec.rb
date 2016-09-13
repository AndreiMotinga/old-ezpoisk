require "rails_helper"

feature "user creates service" do
  scenario "successfully", js: true do
    create_and_login_user
    service = build :service

    visit new_dashboard_service_path
    fill_in "Заголовок", with: service.title
    fill_in "Описание", with: service.text
    find("option[value='#{service.category}']").select_option
    find("option[value='#{service.subcategory}']").select_option
    fill_in "Улица", with: service.street
    select("Alabama", from: "Штат")
    select("Abbeville", from: "Город")
    fill_in "Телефон", with: service.phone
    click_on "details-save-btn"

    expect(page).to have_content service.title

    record = Service.last
    expect(record.category).to eq service.category
    expect(record.subcategory).to eq service.subcategory
    expect(record.text).to eq service.text
    expect(record.street).to eq service.street
    expect(record.user_id).to_not be nil
  end
end
