require "rails_helper"

feature "user updates contacts", js: true do
  scenario "successfully" do
    user = create_and_login_user
    attrs = build :user

    visit edit_user_path(user, act: "contacts")

    fill_in "Телефон", with: attrs.phone
    fill_in "Личный сайт...", with: attrs.site
    fill_in "Facebook", with: attrs.facebook
    fill_in "Vkontakte", with: attrs.vk
    fill_in "Google+", with: attrs.google
    fill_in "Skype", with: attrs.skype
    fill_in "Улица", with: attrs.street
    select user.state.name, from: "Штат"
    select user.city.name, from: "Город"
    click_on "Сохранить"

    expect(page).to have_content I18n.t(:user_updated)
    user.reload
    expect(user.phone).to eq attrs.phone
    expect(user.site).to eq attrs.site
    expect(user.facebook).to eq attrs.facebook
    expect(user.vk).to eq attrs.vk
    expect(user.google).to eq attrs.google
    expect(user.skype).to eq attrs.skype
    expect(user.street).to eq attrs.street
    expect(user.state_id).to eq attrs.state_id
    expect(user.city_id).to eq attrs.city_id
  end
end
