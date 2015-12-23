require "rails_helper"

feature "user deletes re_commercial" do
  scenario "successfully" do
    user = create :user
    login_as(user, scope: :user)
    create :re_commercial, user: user

    visit dashboard_re_commercials_path
    click_on "Destroy"

    expect(ReCommercial.count).to be 0
  end
end
