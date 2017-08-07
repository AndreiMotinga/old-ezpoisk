require "rails_helper"

feature "user updates general info" do
  scenario "successfully" do
    user = create_and_login_user
    attrs = build :user

    visit edit_user_path(user, act: "general")

    fill_in "Имя", with: attrs.name
    fill_in "Коротко о себе...", with: attrs.short_bio
    fill_in "Расскажите о себе...", with: attrs.about
    select attrs.gender, from: "user_gender"

    click_on "Сохранить"

    expect(page).to have_content I18n.t(:user_updated)
    user.reload
    expect(user.name).to eq attrs.name
    expect(user.short_bio).to eq attrs.short_bio
    expect(user.about).to eq attrs.about
    expect(user.gender).to eq attrs.gender
  end
end
