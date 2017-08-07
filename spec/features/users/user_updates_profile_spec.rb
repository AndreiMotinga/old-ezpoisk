# todo move to features
require "rails_helper"

feature "user updates profile" do
  scenario "user updates contacts", js: true do
    user = create_and_login_user
    attrs = build(:user)

    visit edit_user_path(user, act: "contacts")
    fill_in "Телефон", with: attrs.phone
    fill_in "Личный сайт...", with: attrs.site
    fill_in "Facebook", with: attrs.facebook
    fill_in "Google+", with: attrs.google
    fill_in "Vkontakte", with: attrs.vk
    # find(:css, "#profile_user_email").set(attrs.email)

    click_on "contacts-save-btn"
    expect(page).to have_content I18n.t(:user_updated)
    user.reload

    expect(user.phone).to eq attrs.phone
    expect(user.site).to eq attrs.site
    expect(user.facebook).to eq attrs.facebook
    expect(user.google).to eq attrs.google
    expect(user.vk).to eq attrs.vk
    expect(page).to have_content I18n.t(:user_updated)
  end
end
