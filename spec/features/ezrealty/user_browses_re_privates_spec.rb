require "rails_helper"

feature "User browses re_privates" do
  scenario "success" do
    visit re_privates_path
    expect(page).to have_content("Настроить фильтр")
  end
end

feature "User browses re_private" do
  scenario "success" do
    rp = create :re_private

    visit re_private_path(rp)

    expect(page).to have_content rp.title
  end
end
