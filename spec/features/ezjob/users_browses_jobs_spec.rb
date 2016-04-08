require "rails_helper"

feature "User browses jobs" do
  scenario "success" do
    visit ezjob_jobs_path
    expect(page).to have_content("Настроить фильтр")
  end
end

feature "User browses job" do
  scenario "success" do
    j = create :job, :active, description: nil

    visit ezjob_job_path(j)

    expect(page).to have_content j.title
  end
end
