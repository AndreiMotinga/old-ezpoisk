require "rails_helper"

feature "User create re_private" do
  scenario "success", js: true do
    user = create_and_login_user
    re_private = build(:re_private,
                       category: "apartment", post_type: "renting")

    visit new_dashboard_re_private_path
    fill_in "Улица", with: re_private.street
    select("Alabama", from: "Штат")
    select("Abbeville", from: "Город")
    find("option[value='#{re_private.post_type}']").select_option
    find("option[value='#{re_private.duration}']").select_option
    find("option[value='#{re_private.rooms}']").select_option
    find("option[value='#{re_private.category}']").select_option
    fill_in "Телефон", with: re_private.phone
    fill_in "Цена", with: re_private.price
    fill_in "Ванные", with: re_private.baths
    fill_in "Площадь", with: re_private.space
    check("Активно")
    check("Комиссия")
    click_on "Сохранить"

    expect(page).to have_content re_private.street
    expect(page).to have_content I18n.t re_private.post_type
    expect(page).to have_content I18n.t re_private.duration
    expect(page).to have_content re_private.space
    expect(page).to have_content re_private.price
    expect(page).to have_content re_private.baths
    expect(page).to have_content I18n.t re_private.rooms

    re_private_save = RePrivate.last
    expect(re_private_save.active).to be true
    expect(re_private_save.fee).to be true
    expect(re_private_save.phone).to eq re_private.phone
    expect(re_private_save.email).to eq user.email
    expect(re_private_save.state_id).to_not be nil
    expect(re_private_save.city_id).to_not be nil
    expect(re_private_save.user_id).to_not be nil
    expect(re_private_save.token).to_not be nil
  end
end
