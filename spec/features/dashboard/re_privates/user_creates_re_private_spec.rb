require "rails_helper"

feature "User create re_private" do
  scenario "success", js: true do
    user = create :user
    login_as(user, scope: :user)
    re_private = build(:re_private)
    state = State.create(name: "Alabama")
    City.create(name: "Abbeville", state: state)

    visit new_dashboard_re_private_path
    fill_in "Улица", with: re_private.street
    select("аренда", from: "Тип обьявления")
    select("помесячно", from: "Продолжительность")
    fill_in "Квартира", with: re_private.apt
    fill_in "Телефон", with: re_private.phone
    fill_in "Цена", with: re_private.price
    fill_in "Ванные", with: re_private.baths
    fill_in "Площадь", with: re_private.space
    fill_in "Комнат", with: re_private.rooms
    check("Активно?")
    check("Комиссия")
    select("Alabama", from: "Штат")
    select("Abbeville", from: "Город")
    click_on "Сохранить"

    expect(page).to have_content re_private.street
    expect(page).to have_content "АРЕНДА"
    expect(page).to have_content "помесячно"
    expect(page).to have_content re_private.phone
    expect(page).to have_content re_private.space
    expect(page).to have_content re_private.price
    expect(page).to have_content re_private.baths
    expect(page).to have_content re_private.rooms

    expect(RePrivate.count).to be 1
  end
end
