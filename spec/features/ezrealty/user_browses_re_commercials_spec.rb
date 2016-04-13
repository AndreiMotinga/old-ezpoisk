require "rails_helper"

feature "User browses re_commercials" do
  scenario "success" do
    visit re_commercials_path
    expect(page).to have_content("Расширенный поиск")
  end
end

feature "User browses re_commercial" do
  scenario "success" do
    rc = create :re_commercial, :active

    visit re_commercial_path(rc)

    expect(page).to have_content rc.title
  end
end
