require "rails_helper"

feature "user deletes job_agency" do
  scenario "successfully", js: true do
    user = create_and_login_user
    create :job_agency, user: user

    visit dashboard_job_agencies_path
    click_on "Удалить"
    page.driver.browser.accept_js_confirms

    expect(JobAgency.count).to eq 0
  end
end
