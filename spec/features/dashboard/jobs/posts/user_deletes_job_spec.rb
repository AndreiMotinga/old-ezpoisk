require "rails_helper"

feature "user deletes job" do
  scenario "successfully", js: true do
    user = create_and_login_user
    create :job, user: user

    visit dashboard_jobs_path
    click_on "Удалить"
    page.driver.browser.accept_js_confirms

    expect(Job.count).to eq 0
  end
end
