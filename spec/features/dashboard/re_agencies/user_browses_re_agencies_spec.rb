require "rails_helper"

feature "user browses re_agencies" do
  scenario "successfully" do
    user = create_and_login_user
    re_agency = create :re_agency, user: user

    visit dashboard_re_agencies_path

    expect(page).to have_content re_agency.title
  end
end
