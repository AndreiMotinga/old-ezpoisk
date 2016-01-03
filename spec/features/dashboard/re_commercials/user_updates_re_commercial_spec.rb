require "rails_helper"

feature "User updates re_commercial" do
  scenario "success", js: true do
    user = create :user
    login_as(user, scope: :user)
    re_commercial = create :re_commercial, user: user
    updated_re_commercial = build :re_commercial
    state = State.create(name: "Alabama")
    City.create(name: "Abbeville", state: state)

    visit edit_dashboard_re_commercial_path re_commercial

    fill_in "Улица", with: updated_re_commercial.street
    fill_in "Телефон", with: updated_re_commercial.phone
    fill_in "Цена", with: updated_re_commercial.price
    fill_in "Площадь", with: updated_re_commercial.space
    select("продажа", from: "Тип обьявления")
    select("Alabama", from: "Штат")
    select("Abbeville", from: "Город")
    select("офис", from: "Категория")
    check("Активно?")
    click_on "Сохранить"

    # todo:
    # expect(page).to have_content updated_re_commercial.street
    # expect(page).to have_content updated_re_commercial.phone
    # expect(page).to have_content updated_re_commercial.price
    # expect(page).to have_content updated_re_commercial.space
    # expect(page).to have_content updated_re_commercial.description
    # expect(page).to have_content "Продажа"
    # expect(page).to have_content "Alabama"
    # expect(page).to have_content "Abbeville"
    # expect(page).to have_content "office"
    # expect(page).to have_content "true"
    # expect(ReCommercial.last.user).to eq user
  end
end
