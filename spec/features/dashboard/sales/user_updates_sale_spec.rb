require "rails_helper"

feature "user updates sale" do
  scenario "successfully", js: true do
    create_alabama_and_abbeville
    user = create_and_login_user
    sale = create :sale, user: user
    attrs = build(:sale)

    visit edit_dashboard_sale_path sale
    fill_in "Заголовок", with: attrs.title
    fill_in "Телефон", with: attrs.phone
    fill_in "Email", with: attrs.email
    select(attrs.category, from: "Категория")
    select("Alabama", from: "Штат")
    select("Abbeville", from: "Город")
    check("Активно?")
    click_on "details-save-btn"

    expect(page).to have_content I18n.t(:post_saved)
    sale.reload
    expect(sale.title).to eq attrs.title
    expect(sale.phone).to eq attrs.phone
    expect(sale.email).to eq attrs.email
    expect(sale.category).to eq attrs.category
    expect(sale.active).to be true
    expect(sale.state.name).to eq "Alabama"
    expect(sale.city.name).to eq "Abbeville"
  end

  scenario "updates description" do
    user = create_and_login_user
    sale = create :sale, user: user

    visit edit_dashboard_sale_path sale
    fill_in "Описание", with: "New description"
    click_on "description-save-btn"
    sale.reload

    expect(sale.description).to eq "New description"
  end
end
