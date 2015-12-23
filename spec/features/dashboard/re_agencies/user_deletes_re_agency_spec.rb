require "rails_helper"

feature "user deletes re_agency" do
  scenario "successfully" do
    user = create :user
    login_as(user, scope: :user)
    create :re_agency, user: user

    visit dashboard_re_agencies_path
    click_on "Destroy"

    expect(ReAgency.count).to eq 0
  end
end
