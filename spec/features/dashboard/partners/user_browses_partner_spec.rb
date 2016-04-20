require "rails_helper"

feature "user browses partner" do
  scenario "successfully", js: true do
    user = create_and_login_user
    partner = create :partner, user: user

    visit dashboard_partner_path(partner)

    expect(page).to have_content partner.title
    expect(page).to have_content partner.link
  end
end
