require "rails_helper"

feature "user browses partner" do
  scenario "successfully", js: true do
    user = create_and_login_user
    create :partner, user: user

    visit dashboard_partners_path
    accept_confirm { click_on "Удалить" }

    expect(Partner.count).to eq 0
  end
end
