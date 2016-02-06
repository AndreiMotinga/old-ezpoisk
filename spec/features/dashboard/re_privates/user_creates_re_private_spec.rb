require "rails_helper"

feature "User create re_private" do
  scenario "success", js: true do
    create_and_login_user
    re_private = build(:re_private)
    state = State.create(name: "Alabama")
    City.create(name: "Abbeville", state: state)

    visit new_dashboard_re_private_path
    fill_in "Улица", with: re_private.street
    select("Alabama", from: "Штат")
    select("Abbeville", from: "Город")
    select("Аренда", from: "Тип объявления")
    select("помесячно", from: "Квартира сдается")
    fill_in "Телефон", with: re_private.phone
    fill_in "Цена", with: re_private.price
    fill_in "Ванные", with: re_private.baths
    fill_in "Площадь", with: re_private.space
    fill_in "Комнат", with: re_private.rooms
    check("Активно?")
    check("Комиссия")
    click_on "Сохранить"

    expect(page).to have_content re_private.street
    expect(page).to have_content "Аренда"
    expect(page).to have_content "помесячно"
    expect(page).to have_content re_private.phone
    expect(page).to have_content re_private.space
    expect(page).to have_content re_private.price
    expect(page).to have_content re_private.baths
    expect(page).to have_content re_private.rooms

    re_private = RePrivate.last
    expect(re_private.active).to be true
    expect(re_private.fee).to be true
    expect(re_private.state_id).to_not be nil
    expect(re_private.city_id).to_not be nil
    expect(re_private.user_id).to_not be nil
  end
end
