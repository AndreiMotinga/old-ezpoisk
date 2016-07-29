require "rails_helper"

feature "User browses services" do
  scenario "success" do
    visit services_path
    expect(page).to have_content("Настроить фильтр")
  end
end

feature "User browses service" do
  scenario "success" do
    s = create :service

    visit service_path(s)

    expect(page).to have_content s.title
  end
end
