require "rails_helper"

xfeature "User comments on re_private", js: true do
  scenario "user is not logged in" do
    rp = create :re_private

    visit re_private_path(rp)

    expect(page).to have_content "Войдите, чтобы читать/добавлять коментарии"
  end
end
