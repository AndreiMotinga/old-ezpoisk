require "rails_helper"

feature "user creates sale" do
  scenario "successfully", js: true do
    create_and_login_user
    sale = build(:sale)
    visit new_dashboard_sale_path

    fill_in "Заголовок", with: sale.title
    fill_in "Телефон", with: sale.phone
    fill_in "Email", with: sale.email
    select(sale.category, from: "Категория")
    select("Alabama", from: "Штат")
    select("Abbeville", from: "Город")
    check("Активно")

    click_on "Сохранить"

    expect(page).to have_content sale.title

    saved_sale = Sale.last
    expect(saved_sale.active).to be true
    expect(saved_sale.category).to eq sale.category
    expect(saved_sale.phone).to eq sale.phone
    expect(saved_sale.state_id).to_not be nil
    expect(saved_sale.city_id).to_not be nil
    expect(saved_sale.user_id).to_not be nil
  end
end
