# todo move to features
require "rails_helper"

feature "user updates profile" do
  scenario "user updates contacts", js: true do
    user = create_and_login_user
    attrs = build(:user)

    visit edit_user_path user
    fill_in "Телефон", with: attrs.phone
    fill_in "Ваш сайт", with: attrs.site
    fill_in "Facebook", with: attrs.facebook
    fill_in "Google+", with: attrs.google
    fill_in "Vkontakte", with: attrs.vk
    fill_in "Odnoklassniki", with: attrs.ok
    fill_in "Twitter", with: attrs.twitter
    find(:css, "#profile_user_email").set(attrs.email)

    click_on "contacts-save-btn"
    expect(page).to have_content I18n.t(:user_updated)
    user.reload

    expect(user.phone).to eq attrs.phone
    expect(user.site).to eq attrs.site
    expect(user.facebook).to eq attrs.facebook
    expect(user.google).to eq attrs.google
    expect(user.vk).to eq attrs.vk
    expect(user.ok).to eq attrs.ok
    expect(user.twitter).to eq attrs.twitter
    expect(user.email).to eq attrs.email
    expect(page).to have_content I18n.t(:user_updated)
  end

  # scenario "updates address", js: true do
  #   user = create_and_login_user
  #   ny = create :state, name: "New York"
  #   bk = create :city, name: "Brooklyn", state: ny
  #   street = "1970 East 18th str"
  #
  #   visit edit_user_path user
  #   fill_in "Улица", with: street
  #   select("New York", from: "Штат")
  #   select("Brooklyn", from: "Город")
  #   click_on "address-save-btn"
  #   user.reload
  #
  #   expect(page).to have_content I18n.t(:user_updated)
  #   expect(user.street).to eq street
  #   # expect(user.state).to eq ny
  #   expect(user.city.name).to eq "Brooklyn"
  # end
end
