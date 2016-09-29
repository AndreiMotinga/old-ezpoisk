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

    rp = RePrivate.last
    expect(rp.active).to be true
    expect(rp.fee).to be true
    expect(rp.phone).to eq re_private.phone
    expect(rp.email).to eq user.email
    expect(rp.state_id).to_not be nil
    expect(rp.city_id).to_not be nil
    expect(rp.user_id).to_not be nil
    expect(rp.token).to_not be nil
  end
end
