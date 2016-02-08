require "rails_helper"

feature "User updates re_commercial" do
  scenario "success", js: true do
    create_alabama_and_abbeville
    user = create_and_login_user
    re_commercial = create :re_commercial, user: user
    attrs = build :re_commercial

    visit edit_dashboard_re_commercial_path re_commercial
    fill_in "Улица", with: attrs.street
    fill_in "Телефон", with: attrs.phone
    fill_in "Цена", with: attrs.price
    fill_in "Площадь", with: attrs.space
    select(attrs.post_type, from: "Тип объявления")
    select("Alabama", from: "Штат")
    select("Abbeville", from: "Город")
    select(attrs.category, from: "Категория")
    check("Активно")
    click_on "details-save-btn"

    expect(page).to have_content I18n.t(:post_saved)
    re_commercial.reload
    expect(re_commercial.phone).to eq attrs.phone
    expect(re_commercial.price).to eq attrs.price
    expect(re_commercial.space).to eq attrs.space
    expect(re_commercial.post_type).to eq attrs.post_type
    expect(re_commercial.category).to eq attrs.category
    expect(re_commercial.active).to be true
    expect(re_commercial.state.name).to eq "Alabama"
    expect(re_commercial.city.name).to eq "Abbeville"
  end

  scenario "updates description" do
    user = create_and_login_user
    re_commercial = create :re_commercial, user: user

    visit edit_dashboard_re_commercial_path re_commercial
    fill_in "Описание", with: "New description"
    click_on "description-save-btn"
    re_commercial.reload

    expect(re_commercial.description).to eq "New description"
  end
end
