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
    select(service.category, from: "Раздел")
    select(service.subcategory, from: "Категория")
    select("Alabama", from: "Штат")
    select("Abbeville", from: "Город")
    click_on "details-save-btn"

    expect(page).to have_content service.title
    expect(page).to have_content service.site

    record = Service.last
    expect(record.category).to eq service.category
    expect(record.subcategory).to eq service.subcategory
    expect(record.phone).to eq service.phone
    expect(record.state.name).to eq "Alabama"
    expect(record.city.name).to eq "Abbeville"
    expect(record.user_id).to_not be nil
  end

  # uncomment when services are paid
  # scenario "there is a payment button", js: true do
  #   user = create_and_login_user
  #   service = create :service, active_until: nil, user: user
  #
  #   visit edit_dashboard_service_path(service)
  #   click_on "Оплата"
  #
  #   expect(page).to have_css("select#plan")
  # end

  scenario "it display active_until when user has paid for it", js: true do
    user = create_and_login_user
    service = create :service, user: user

    visit edit_dashboard_service_path(service)
    click_on "Оплата"

    string = "Объявление активно до #{service.active_until}"
    expect(page).to have_content(string)
  end
end
