require "rails_helper"

feature "user deletes re_agency" do
  scenario "successfully", js: true do
    user = create_and_login_user
    re_a = create :re_agency, user: user

    visit edit_dashboard_re_agency_path(re_a)
    click_on "Детали"
    click_on "Удалить"
    page.driver.browser.accept_js_confirms
    # page.driver.browser.reject_js_confirms

    expect(ReAgency.count).to eq 0
  end
end
