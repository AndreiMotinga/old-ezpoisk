require "rails_helper"

feature "User create re_commercial" do
  scenario "success", js: true do
    create_alabama_and_abbeville
    create_and_login_user
    re_commercial = build(:re_commercial)

    visit new_dashboard_re_commercial_path
    fill_in "Улица", with: re_commercial.street
    fill_in "Телефон", with: re_commercial.phone
    select("Alabama", from: "Штат")
    select("Abbeville", from: "Город")
    select("Офис", from: "Категория")
    select("Аренда", from:  "Тип объявления")
    fill_in "Цена", with: re_commercial.price
    fill_in "Площадь", with: re_commercial.space
    fill_in "Телефон", with: re_commercial.phone
    check("Активно?")

    click_on "Сохранить"

    expect(page).to have_content re_commercial.street
    expect(page).to have_content re_commercial.phone
    expect(page).to have_content re_commercial.price
    expect(page).to have_content re_commercial.space
    expect(page).to have_content re_commercial.space
    expect(page).to have_content "Аренда"
    expect(page).to have_content "Офис"

    re_commercial = ReCommercial.last
    expect(re_commercial.active).to be true
    expect(re_commercial.state_id).to_not be nil
    expect(re_commercial.city_id).to_not be nil
    expect(re_commercial.user_id).to_not be nil
  end
end
