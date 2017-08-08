require "rails_helper"

feature "user updates contacts", js: true do
  scenario "successfully" do
    user = create_and_login_user
    attrs = build :contact

    visit edit_user_path(user, act: "contacts")

    fill_in "Телефон", with: attrs.phone
    fill_in "Личный сайт...", with: attrs.site
    fill_in "Facebook", with: attrs.fb
    fill_in "Vkontakte", with: attrs.vk
    fill_in "Google+", with: attrs.google
    fill_in "Skype", with: attrs.skype
    fill_in "Улица", with: attrs.street
    select attrs.state.name, from: "Штат"
    select attrs.city.name, from: "Город"
    click_on "Сохранить"

    expect(page).to have_content I18n.t(:user_updated)
    contact = user.reload.contact
    expect(contact.phone).to eq attrs.phone
    expect(contact.site).to eq attrs.site
    expect(contact.fb).to eq attrs.fb
    expect(contact.vk).to eq attrs.vk
    expect(contact.google).to eq attrs.google
    expect(contact.skype).to eq attrs.skype
    expect(contact.street).to eq attrs.street
    expect(contact.state_id).to eq attrs.state_id
    expect(contact.city_id).to eq attrs.city_id
  end
end
