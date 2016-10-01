require "rails_helper"

feature "User browses jobs" do
  scenario "success" do
    visit jobs_path

    expect(page).to have_content("Настроить фильтр")
  end
end
