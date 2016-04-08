require "rails_helper"

feature "User browses sales" do
  scenario "success" do
    visit sales_path
    expect(page).to have_content("Настроить фильтр")
  end
end

feature "User browses sale" do
  scenario "success" do
    s = create :sale, :active

    visit sale_path(s)

    expect(page).to have_content s.title
  end
end
