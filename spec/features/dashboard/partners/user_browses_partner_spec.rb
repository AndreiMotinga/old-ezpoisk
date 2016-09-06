require "rails_helper"

feature "user browses partner" do
  scenario "successfully" do
    user = create_and_login_user
    partner = create :partner, user: user

    visit edit_dashboard_partner_path(partner)

    expect(page).to have_content partner.title
  end
end
