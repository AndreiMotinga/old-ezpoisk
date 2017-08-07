require "rails_helper"

feature "user removes education" do
  scenario "successfully" do
    user = create_and_login_user
    create :experience, :education, user: user

    visit edit_user_path(user, act: "education")
    click_on "Удалить"

    expect(page).to have_content I18n.t(:user_updated)
    user.reload
    expect(user.experiences.size).to eq 0
  end
end
