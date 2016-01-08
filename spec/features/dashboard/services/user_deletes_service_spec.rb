require "rails_helper"

feature "user deletes service" do
  scenario "successfully" do
    user = create_and_login_user
    create :service, user: user

    visit dashboard_services_path
    click_on "Удалить"

    expect(Service.count).to be 0
  end
end
