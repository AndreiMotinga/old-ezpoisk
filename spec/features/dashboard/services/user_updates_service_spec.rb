require "rails_helper"

feature "user updates service" do
  scenario "successfully", js: true do
    user = create_and_login_user
    service = create(:service, user: user)
    attrs = build(:service)

    visit edit_dashboard_service_path service
    click_on "Детали"
    fill_in "Заголовок", with: attrs.title
    fill_in "Улица", with: attrs.street
    fill_in "Телефон", with: attrs.phone
    fill_in "Email", with: attrs.email
    fill_in "Сайт", with: attrs.site
    find("option[value='#{attrs.category}']").select_option
    find("option[value='#{attrs.subcategory}']").select_option
    select("Alabama", from: "Штат")
    select("Abbeville", from: "Город")
    click_on "details-save-btn"

    expect(page).to have_content I18n.t(:post_saved)
    service.reload
    expect(service.title).to eq attrs.title
    expect(service.street).to eq attrs.street
    expect(service.phone).to eq attrs.phone
    expect(service.site).to eq attrs.site
    expect(service.email).to eq attrs.email
    expect(service.category).to eq attrs.category
    expect(service.subcategory).to eq attrs.subcategory
    expect(service.state_name).to eq "Alabama"
    expect(service.city_name).to eq "Abbeville"
    expect(service.user_id).to_not be nil
  end

  scenario "updates text" do
    user = create_and_login_user
    service = create :service, user: user

    visit edit_dashboard_service_path service
    fill_in "Описание", with: "New text"
    click_on "details-save-btn"
    service.reload

    expect(service.text).to eq "New text"
  end
end
