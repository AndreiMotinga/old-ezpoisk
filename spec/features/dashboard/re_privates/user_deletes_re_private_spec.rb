require "rails_helper"

feature "user deletes re_private" do
  scenario "successfully" do
    user = create :user
    login_as(user, scope: :user)
    re_private = create :re_private, user: user

    visit dashboard_re_privates_path
    click_on "Destroy"

    expect(RePrivate.count).to be 0
  end
end
