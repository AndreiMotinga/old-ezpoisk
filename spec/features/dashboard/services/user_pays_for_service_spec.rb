require "rails_helper"

xfeature "user pays for service" do
  scenario "successfully", js: true do
    user = create_and_login_user
    service = create :service, user: user

    visit edit_dashboard_service_path(service)
    find(:css, "#payment").click
    find(:css, "input[data-stripe='number']").set("4242 4242 4242 4242")
    find(:css, "input[data-stripe='exp_month']").set("12")
    find(:css, "input[data-stripe='exp_year']").set("21")
    find(:css, "input[data-stripe='cvc']").set("212")
    find(:css, "#submit-payment").click

    expect(StripeSubscription.count).to be 1
  end
end
