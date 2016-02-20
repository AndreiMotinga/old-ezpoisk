require "rails_helper"

feature "User browses jobs" do
  scenario "success" do
    visit jobs_jobs_path
    expect(page).to have_content("Расширенный поиск")
  end
end

feature "User browses job" do
  scenario "success" do
    j = create :job, :active

    visit jobs_job_path(j)

    expect(page).to have_content j.title
  end
end
