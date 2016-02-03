require "rails_helper"

feature "user deletes re_commercial" do
  scenario "successfully" do
    user = create_and_login_user
    re_c = create :re_commercial, user: user

    visit edit_dashboard_re_commercial_path(re_c)
    click_on "Удалить"

    expect(ReCommercial.count).to be 0
  end
end
