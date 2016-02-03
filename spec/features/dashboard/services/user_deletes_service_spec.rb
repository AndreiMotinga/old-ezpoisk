require "rails_helper"

feature "user deletes service" do
  scenario "successfully" do
    user = create_and_login_user
    service = create :service, user: user

    visit edit_dashboard_service_path(service)
    click_on "Удалить"

    expect(Service.count).to be 0
  end
end
