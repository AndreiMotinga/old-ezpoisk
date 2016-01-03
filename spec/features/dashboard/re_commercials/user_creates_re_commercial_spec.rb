require "rails_helper"

feature "User create re_commercial" do
  scenario "success", js: true do
    user = create :user
    login_as(user, scope: :user)
    re_commercial = build(:re_commercial)
    state = State.create(name: "Alabama")
    City.create(name: "Abbeville", state: state)

    visit new_dashboard_re_commercial_path
    fill_in "Улица", with: re_commercial.street
    fill_in "Телефон", with: re_commercial.phone
    select("Alabama", from: "Штат")
    select("Abbeville", from: "Город")
    select("офис", from: "Категория")
    select("аренда", from:  "Тип обьявления")
    fill_in "Цена", with: re_commercial.price
    fill_in "Площадь", with: re_commercial.space
    fill_in "Телефон", with: re_commercial.phone
    check("Активно?")
    click_on "Сохранить"

    # todo
    # expect(page).to have_content re_commercial.street
    # expect(page).to have_content re_commercial.phone
    # expect(page).to have_content re_commercial.price
    # expect(page).to have_content re_commercial.space
    # expect(page).to have_content re_commercial.space
    # expect(page).to have_content re_commercial.description
    # expect(page).to have_content "Аренда"
    # expect(page).to have_content "Alabama"
    # expect(page).to have_content "Abbeville"
    # expect(page).to have_content "office"
    # expect(page).to have_content "true"
    # expect(ReCommercial.count).to eq 1
  end
end
