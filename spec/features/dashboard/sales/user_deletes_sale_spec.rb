require "rails_helper"

feature "user deletes sale" do
  scenario "successfully" do
    user = create_and_login_user
    sale = create :sale, user: user

    visit edit_dashboard_sale_path(sale)
    click_on "Удалить"

    expect(Sale.count).to be 0
  end
end
