require "rails_helper"

feature "user creates sale" do
  scenario "successfully", js: true do
    create_alabama_and_abbeville
    create_and_login_user

    visit new_dashboard_sale_path
    sale = build(:sale)

    fill_in "Заголовок", with: sale.title
    fill_in "Телефон", with: sale.phone
    fill_in "Email", with: sale.email
    select(sale.category, from: "Категория")
    select("Alabama", from: "Штат")
    select("Abbeville", from: "Город")
    check("Активно?")

    click_on "Сохранить"

    expect(page).to have_content sale.title
    expect(page).to have_content sale.phone
    expect(page).to have_content sale.email

    saved_sale = Sale.last
    expect(saved_sale.active).to be true
    expect(saved_sale.category).to eq sale.category
    expect(saved_sale.state_id).to_not be nil
    expect(saved_sale.city_id).to_not be nil
    expect(saved_sale.user_id).to_not be nil
  end
end
