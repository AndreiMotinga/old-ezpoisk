require "rails_helper"

feature "user browses re_privates" do
  scenario "successfully" do
    user = create_and_login_user
    re_private = create :re_private, user: user

    visit dashboard_re_privates_path

    expect(page).to have_content re_private.street
  end
end
