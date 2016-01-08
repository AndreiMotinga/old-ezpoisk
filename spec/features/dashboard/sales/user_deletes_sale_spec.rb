require "rails_helper"

feature "user deletes sale" do
  scenario "successfully" do
    user = create_and_login_user
    create :sale, user: user

    visit dashboard_sales_path
    click_on "Удалить"

    expect(Sale.count).to be 0
  end
end
