require "rails_helper"

feature "user browses re_commercials" do
  scenario "successfully" do
    user = create_and_login_user
    re_commercial = create :re_commercial, user: user

    visit dashboard_re_commercials_path

    expect(page).to have_content re_commercial.street
  end
end
