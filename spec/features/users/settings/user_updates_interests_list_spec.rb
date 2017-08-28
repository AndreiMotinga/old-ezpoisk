require "rails_helper"

feature "user updates interests", js: true do
  scenario "successfully" do
    user = create_and_login_user

    visit edit_user_path(user, act: "interests")
    select2("недвижимость", from: "Укажите ваши интересы")
    select2("работа", from: "Укажите ваши интересы")
    click_on "Сохранить"

    expect(page).to have_content I18n.t(:user_updated)
    user.reload
    expect(user.interest_list).to match_array %W[недвижимость работа]
  end
end
