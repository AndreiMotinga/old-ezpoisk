require "rails_helper"

feature "User browses jobs" do
  scenario "success" do
    visit jobs_path

    expect(page).to have_content("Настроить фильтр")
  end
end

feature "User browses job" do
  scenario "success" do
    j = create :job

    visit job_path(j)

    expect(page).to have_content j.description
  end
end
