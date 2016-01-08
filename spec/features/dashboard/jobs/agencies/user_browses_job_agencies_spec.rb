require "rails_helper"

feature "user browses job_agencies" do
  scenario "successfully" do
    user = create_and_login_user
    job_agency = create :job_agency, user: user
    other_job_agency = create :job_agency, user: user

    visit dashboard_job_agencies_path

    expect(page).to have_content job_agency.title
    expect(page).to have_content other_job_agency.title
  end
end
