require "rails_helper"

feature "user updates profile" do
  scenario "user updates contacts", js: true do
    user = create_and_login_user
    profile = user.profile
    attrs = build(:profile)

    visit edit_dashboard_profile_path profile
    fill_in "Телефон", with: attrs.phone
    fill_in "Ваш сайт", with: attrs.site
    fill_in "Facebook", with: attrs.facebook
    fill_in "Google+", with: attrs.google
    fill_in "Vkontakte", with: attrs.vk
    fill_in "Odnoklassniki", with: attrs.ok
    fill_in "Twitter", with: attrs.twitter

    click_on "contacts-save-btn"
    expect(page).to have_content I18n.t(:profile_updated)
    profile.reload

    expect(profile.phone).to eq attrs.phone
    expect(profile.site).to eq attrs.site
    expect(profile.facebook).to eq attrs.facebook
    expect(profile.google).to eq attrs.google
    expect(profile.vk).to eq attrs.vk
    expect(profile.ok).to eq attrs.ok
    expect(profile.twitter).to eq attrs.twitter
    expect(page).to have_content I18n.t(:profile_updated)
  end

  # scenario "updates address", js: true do
  #   user = create_and_login_user
  #   profile = create :profile, user: user
  #   ny = create :state, name: "New York"
  #   bk = create :city, name: "Brooklyn", state: ny
  #   street = "1970 East 18th str"
  #
  #   visit edit_dashboard_profile_path profile
  #   fill_in "Улица", with: street
  #   select("New York", from: "Штат")
  #   select("Brooklyn", from: "Город")
  #   click_on "address-save-btn"
  #   profile.reload
  #
  #   expect(page).to have_content I18n.t(:profile_updated)
  #   expect(profile.street).to eq street
  #   # expect(profile.state).to eq ny
  #   expect(profile.city.name).to eq "Brooklyn"
  # end

  scenario "user updates email" do
    user = create_and_login_user
    profile = user.profile

    visit edit_dashboard_profile_path profile
    find(:css, "#profile_user_email").set("foo@bar.com")
    click_on "email-save-btn"
    profile.reload

    expect(page).to have_content I18n.t(:profile_updated)
    expect(profile.user_email).to eq "foo@bar.com"
  end
end
