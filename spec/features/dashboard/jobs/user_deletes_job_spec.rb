require "rails_helper"

feature "user deletes job" do
  scenario "successfully", js: true do
    user = create_and_login_user
    job = create :job, user: user

    visit edit_dashboard_job_path(job)
    accept_confirm { click_link("Удалить") }

    expect(Job.count).to eq 0
  end
end
