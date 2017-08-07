require "rails_helper"

feature "user updates skills", js: true do
  scenario "successfully" do
    user = create_and_login_user

    visit edit_user_path(user, act: "skills")
    select2("недвижимость", from: "Навыки")
    select2("работа", from: "Навыки")
    click_on "Сохранить"

    expect(page).to have_content I18n.t(:user_updated)
    user.reload
    expect(user.tag_list).to match ["недвижимость", "работа"]
  end
end
