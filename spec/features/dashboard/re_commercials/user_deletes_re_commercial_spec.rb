require "rails_helper"

feature "user deletes re_commercial" do
  scenario "successfully" do
    user = create_and_login_user
    create :re_commercial, user: user

    visit dashboard_re_commercials_path
    click_on "Удалить"

    expect(ReCommercial.count).to be 0
  end
end
