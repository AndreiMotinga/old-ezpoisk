require "rails_helper"

feature "User comments on listing", js: true do
  scenario "user is not logged in" do
    rp = create :listing

    visit listing_path(rp)
    fill_in("comment_text", with: "foo")

    expect(page).to have_content "Войти с Facebook"
  end
end
