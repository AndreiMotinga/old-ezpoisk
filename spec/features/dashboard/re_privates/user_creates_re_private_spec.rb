require "rails_helper"

feature "User create re_private" do
  scenario "success", js: true do
    user = create_and_login_user
    re_private = build(:re_private)

    visit new_dashboard_re_private_path
    fill_in "Улица", with: re_private.street
    select("Alabama", from: "Штат")
    select("Abbeville", from: "Город")
    select(re_private.post_type, from: "Тип объявления")
    select("помесячно", from: "Продолжительность")
    select(re_private.rooms, from: "Комнат")
    fill_in "Телефон", with: re_private.phone
    fill_in "Цена", with: re_private.price
    fill_in "Ванные", with: re_private.baths
    fill_in "Площадь", with: re_private.space
    check("Активно")
    check("Комиссия")
    click_on "Сохранить"

    expect(page).to have_content re_private.street
    expect(page).to have_content re_private.post_type
    expect(page).to have_content "помесячно"
    expect(page).to have_content re_private.space
    expect(page).to have_content re_private.price
    expect(page).to have_content re_private.baths
    expect(page).to have_content re_private.rooms

    re_private_save = RePrivate.last
    expect(re_private_save.active).to be true
    expect(re_private_save.fee).to be true
    expect(re_private_save.phone).to eq re_private.phone
    expect(re_private_save.email).to eq user.email
    expect(re_private_save.state_id).to_not be nil
    expect(re_private_save.city_id).to_not be nil
    expect(re_private_save.user_id).to_not be nil
  end
end
