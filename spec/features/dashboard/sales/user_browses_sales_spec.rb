require "rails_helper"

feature "user browses sales" do
  scenario "successfully" do
    user = create_and_login_user
    sale = create :sale, user: user
    other_sale = create :sale, user: user

    visit dashboard_sales_path

    expect(page).to have_content sale.title
    expect(page).to have_content other_sale.title
  end
end
