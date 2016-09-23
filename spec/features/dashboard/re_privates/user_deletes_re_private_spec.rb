require "rails_helper"

feature "user deletes re_private" do
  scenario "successfully" do
    user = create_and_login_user
    re_p = create :re_private, user: user

    visit edit_dashboard_re_private_path(re_p)
    click_on "Удалить Объявление"

    expect(RePrivate.count).to be 0
  end
end
