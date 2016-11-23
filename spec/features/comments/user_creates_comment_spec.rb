# todo fix, and find all xfeature and fix
require "rails_helper"

xfeature "User comments on listing", js: true do
  scenario "user is not logged in" do
    rp = create :listing

    visit listing_path(rp)

    expect(page).to have_content "Войдите, чтобы читать/добавлять комментарии"
  end
end
