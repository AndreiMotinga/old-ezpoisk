require "rails_helper"

feature "user creates listing" do
  scenario "successfully", js: true do
    user = create_and_login_user
    record = create :listing, :job, user: user
    listing = build :listing, :apartment

    visit edit_dashboard_listing_path record

    select(I18n.t(listing.kind), from: "Раздел")
    select(I18n.t(listing.category), from: "Категория")
    select(I18n.t(listing.subcategory), from: "Подкатегория")

    fill_in "Заголовок", with: listing.title
    fill_in "Телефон", with: listing.phone
    fill_in "Email", with: listing.email
    select("Alabama", from: "Штат")
    select("Abbeville", from: "Город")

    click_on "Сохранить"

    expect(page).to have_content I18n.t(:post_saved)
    record.reload
    expect(record.kind).to eq listing.kind
    expect(record.category).to eq listing.category
    expect(record.subcategory).to eq listing.subcategory

    expect(record.title).to eq listing.title
    expect(record.phone).to eq listing.phone
    expect(record.email).to eq listing.email
  end
end
