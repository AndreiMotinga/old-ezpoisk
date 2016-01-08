require "rails_helper"

feature "user deletes re_agency" do
  scenario "successfully", js: true do
    user = create_and_login_user
    create :re_agency, user: user

    visit dashboard_re_agencies_path
    click_on "Удалить"
    page.driver.browser.accept_js_confirms
    # page.driver.browser.reject_js_confirms

    expect(ReAgency.count).to eq 0
  end
end
