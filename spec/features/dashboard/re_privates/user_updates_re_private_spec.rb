require "rails_helper"

feature "user creates re_private" do
  scenario "successfully", js: true do
    re_private = create :re_private
    updated_re_private = build :re_private
    state = State.create(name: "Alabama")
    City.create(name: "Abbeville", state: state)
    user = create :user
    login_as(user, scope: :user)

    visit edit_dashboard_re_private_path re_private

    fill_in "Улица", with: updated_re_private.street
    select("Аренда", from: "Тип обьявления")
    select("Месяц", from: "Продолжительность")
    fill_in "Квартира", with: updated_re_private.apt
    fill_in "Телефон", with: updated_re_private.phone
    fill_in "Цена", with: updated_re_private.price
    fill_in "Ванные", with: updated_re_private.baths
    fill_in "Площадь", with: updated_re_private.space
    fill_in "Комнат", with: updated_re_private.rooms
    check("Активно?")
    check("Комиссия")
    select("Alabama", from: "Штат")
    select("Abbeville", from: "Город")
    click_on "Сохранить"



    expect(page).to have_content updated_re_private.street
  end
end
