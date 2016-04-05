require "rails_helper"

feature "user creates re_private" do
  scenario "successfully", js: true do
    create_alabama_and_abbeville
    user = create_and_login_user
    re_private = create :re_private, user: user
    attrs = build :re_private

    visit edit_dashboard_re_private_path re_private
    click_on "Детали"

    fill_in "Улица", with: attrs.street
    select(attrs.post_type, from: "Тип объявления")
    select(attrs.duration, from: "Квартира сдается")
    select(attrs.rooms, from: "Комнат")
    fill_in "Телефон", with: attrs.phone
    fill_in "Цена", with: attrs.price
    fill_in "Ванные", with: attrs.baths
    fill_in "Площадь", with: attrs.space
    check("Активно")
    check("Комиссия")
    select("Alabama", from: "Штат")
    select("Abbeville", from: "Город")

    click_on "details-save-btn"

    expect(page).to have_content I18n.t(:post_saved)
    re_private.reload
    expect(re_private.street).to eq attrs.street
    expect(re_private.post_type).to eq attrs.post_type
    expect(re_private.duration).to eq attrs.duration
    expect(re_private.phone).to eq attrs.phone
    expect(re_private.price).to eq attrs.price
    expect(re_private.baths).to eq attrs.baths
    expect(re_private.rooms).to eq attrs.rooms
    expect(re_private.space).to eq attrs.space
    expect(re_private.active).to be true
    expect(re_private.fee).to be true
    expect(re_private.state.name).to eq "Alabama"
    expect(re_private.city.name).to eq "Abbeville"
  end

  scenario "updates description" do
    user = create_and_login_user

    re_private = create :re_private, user: user

    visit edit_dashboard_re_private_path re_private
    fill_in "Описание", with: "New description"
    click_on "details-save-btn"
    re_private.reload

    expect(re_private.description).to eq "New description"
  end
end
