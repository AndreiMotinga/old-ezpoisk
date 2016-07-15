require "rails_helper"

feature "User create re_commercial" do
  scenario "success", js: true do
    user = create_and_login_user
    re_commercial = build(:re_commercial)

    visit new_dashboard_re_commercial_path
    fill_in "Улица", with: re_commercial.street
    fill_in "Телефон", with: re_commercial.phone
    select("Alabama", from: "Штат")
    select("Abbeville", from: "Город")
    select("Офис", from: "Категория")
    select(re_commercial.post_type, from:  "Тип объявления")
    fill_in "Цена", with: re_commercial.price
    fill_in "Площадь", with: re_commercial.space
    fill_in "Телефон", with: re_commercial.phone
    check("Активно")

    click_on "Сохранить"

    expect(page).to have_content re_commercial.street
    expect(page).to have_content re_commercial.price
    expect(page).to have_content re_commercial.space
    expect(page).to have_content re_commercial.space
    expect(page).to have_content re_commercial.post_type
    expect(page).to have_content "Офис"

    re_commercial_saved = ReCommercial.last
    expect(re_commercial_saved.active).to be true
    expect(re_commercial_saved.phone).to eq re_commercial_saved.phone
    expect(re_commercial_saved.email).to eq user.email
    expect(re_commercial_saved.state_id).to_not be nil
    expect(re_commercial_saved.city_id).to_not be nil
    expect(re_commercial_saved.user_id).to_not be nil
  end
end
