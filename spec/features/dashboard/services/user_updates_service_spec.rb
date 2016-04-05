require "rails_helper"

feature "user updates service" do
  scenario "successfully", js: true do
    create_alabama_and_abbeville
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
    select(attrs.category, from: "Раздел")
    select(attrs.subcategory, from: "Категория")
    select("Alabama", from: "Штат")
    select("Abbeville", from: "Город")
    check("Активно")
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
    expect(service.active).to be true
    expect(service.state.name).to eq "Alabama"
    expect(service.city.name).to eq "Abbeville"
    expect(service.user_id).to_not be nil
  end

  scenario "updates description" do
    user = create_and_login_user
    service = create :service, user: user

    visit edit_dashboard_service_path service
    fill_in "Описание", with: "New description"
    click_on "details-save-btn"
    service.reload

    expect(service.description).to eq "New description"
  end
end
