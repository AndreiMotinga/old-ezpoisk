require "rails_helper"

feature "user browses services" do
  scenario "successfully" do
    user = create_and_login_user
    service = create :service, user: user

    visit dashboard_services_path

    expect(page).to have_content service.title
  end
end
