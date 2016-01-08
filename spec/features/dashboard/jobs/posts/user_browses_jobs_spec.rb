require "rails_helper"

feature "user browses jobs" do
  scenario "successfully" do
    user = create_and_login_user
    job = create :job, user: user
    other_job = create :job, user: user

    visit dashboard_jobs_path

    expect(page).to have_content job.title
    expect(page).to have_content other_job.title
  end
end
