require "rails_helper"

feature "user deletes job_agency" do
  scenario "successfully", js: true do
    user = create_and_login_user
    job_a = create :job_agency, user: user

    visit edit_dashboard_job_agency_path(job_a)
    click_on "Удалить"
    page.driver.browser.accept_js_confirms

    expect(JobAgency.count).to eq 0
  end
end
