require "rails_helper"

feature "user updates service" do
  scenario "successfully", js: true do
    user = create_and_login_user
    service = create(:service, user: user)
    attrs = build(:service)

    visit edit_dashboard_service_path service
    click_on "Детали"
    fill_in "Заголовок", with: attrs.title
    fill_in "Описание", with: attrs.text
    find("option[value='#{attrs.category}']").select_option
    find("option[value='#{attrs.subcategory}']").select_option
    fill_in "Улица", with: attrs.street
    select("Alabama", from: "Штат")
    select("Abbeville", from: "Город")

    fill_in "Телефон", with: attrs.phone
    fill_in "Email", with: attrs.email
    fill_in "Сайт", with: attrs.site
    fill_in "Facebook", with: attrs.fb
    fill_in "Vkontakte", with: attrs.vk
    fill_in "Google+", with: attrs.google
    fill_in "Odnoklassniki", with: attrs.ok
    fill_in "Twitter", with: attrs.twitter
    click_on "details-save-btn"

    expect(page).to have_content I18n.t(:post_saved)
    service.reload
    expect(service.title).to eq attrs.title
    expect(service.text).to eq attrs.text
    expect(service.street).to eq attrs.street
    expect(service.category).to eq attrs.category
    expect(service.subcategory).to eq attrs.subcategory
    expect(service.state_name).to eq "Alabama"
    expect(service.city_name).to eq "Abbeville"
    expect(service.user_id).to_not be nil
    expect(service.phone).to eq attrs.phone
    expect(service.email).to eq attrs.email
    expect(service.site).to eq attrs.site
    expect(service.fb).to eq attrs.fb
    expect(service.ok).to eq attrs.ok
    expect(service.vk).to eq attrs.vk
    expect(service.google).to eq attrs.google
    expect(service.twitter).to eq attrs.twitter
  end
end
