require "rails_helper"

feature "user deletes re_agency" do
  scenario "successfully" do
    user = create :user
    login_as(user, scope: :user)
    re_agency = create :re_agency, user: user

    visit dashboard_re_agencies_path
    click_on "Destroy"

    expect(page).to_not have_content re_agency.title
  end
end
