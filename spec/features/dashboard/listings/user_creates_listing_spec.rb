require "rails_helper"

feature "user creates listing" do
  scenario "user creates job", js: true do
    create_and_login_user

    visit new_dashboard_listing_path
    listing = build :listing, :job

    select(I18n.t(listing.kind), from: "Раздел")
    select(I18n.t(listing.category), from: "Категория")
    select(I18n.t(listing.subcategory), from: "Подкатегория")

    fill_in "Заголовок", with: listing.title
    fill_in "Описание", with: listing.text

    fill_in "Телефон", with: listing.phone
    fill_in "Email", with: listing.email
    fill_in "Я vkontakte", with: listing.vk
    fill_in "Я в facebook", with: listing.fb
    fill_in "Я в twitter", with: listing.tw
    fill_in "Я в odnoklassniki", with: listing.ok
    fill_in "Я в google", with: listing.gl
    fill_in "Я online", with: listing.site

    fill_in "Улица", with: listing.street
    select("Alabama", from: "Штат")
    select("Abbeville", from: "Город")
    check("Активно")

    click_on "Сохранить"

    expect(page).to have_content I18n.t(:post_created)
    saved_listing = Listing.last
    expect(saved_listing.kind).to eq "jobs"
    expect(saved_listing.category).to eq listing.category
    expect(saved_listing.subcategory).to eq listing.subcategory

    expect(saved_listing.title).to eq listing.title
    expect(saved_listing.text).to eq listing.text

    expect(saved_listing.phone).to eq listing.phone
    expect(saved_listing.email).to eq listing.email
    expect(saved_listing.vk).to eq listing.vk
    expect(saved_listing.fb).to eq listing.fb
    expect(saved_listing.tw).to eq listing.tw
    expect(saved_listing.ok).to eq listing.ok
    expect(saved_listing.gl).to eq listing.gl
    expect(saved_listing.site).to eq listing.site

    expect(saved_listing.street).to eq listing.street
    expect(saved_listing.state.name).to eq "Alabama"
    expect(saved_listing.city.name).to eq "Abbeville"

    expect(saved_listing.user_id).to_not be nil
  end

  scenario "user creates apartment", js: true do
    create_and_login_user

    visit new_dashboard_listing_path
    listing = build :listing, :apartment

    find("option[value='#{listing.kind}']").select_option
    find("option[value='#{listing.category}']").select_option
    find("option[value='#{listing.subcategory}']").select_option

    fill_in "Цена", with: listing.price
    fill_in "Площадь", with: listing.space
    fill_in "Ванные", with: listing.baths
    find("option[value='#{listing.rooms}']").select_option
    find("option[value='#{listing.duration}']").select_option

    fill_in "Заголовок", with: listing.title
    fill_in "Описание", with: listing.text
    fill_in "Телефон", with: listing.phone

    fill_in "Улица", with: listing.street
    select("Alabama", from: "Штат")
    select("Abbeville", from: "Город")
    check("Активно")

    click_on "Сохранить"

    expect(page).to have_content I18n.t(:post_created)
    saved_listing = Listing.last

    expect(saved_listing.kind).to eq "real-estate"
    expect(saved_listing.category).to eq listing.category
    expect(saved_listing.subcategory).to eq listing.subcategory
    expect(saved_listing.price).to eq listing.price
    expect(saved_listing.space).to eq listing.space
    expect(saved_listing.baths).to eq listing.baths
    expect(saved_listing.rooms).to eq listing.rooms
    expect(saved_listing.duration).to eq listing.duration
    expect(saved_listing.title).to eq listing.title
    expect(saved_listing.text).to eq listing.text
    expect(saved_listing.phone).to eq listing.phone
    expect(saved_listing.street).to eq listing.street
    expect(saved_listing.state.name).to eq "Alabama"
    expect(saved_listing.city.name).to eq "Abbeville"
  end

  scenario "user creates service", js: true do
    create_and_login_user

    visit new_dashboard_listing_path
    listing = build :listing, :service

    find("option[value='#{listing.kind}']").select_option
    find("option[value='#{listing.category}']").select_option
    find("option[value='#{listing.subcategory}']").select_option

    fill_in "Заголовок", with: listing.title
    fill_in "Описание", with: listing.text
    fill_in "Телефон", with: listing.phone

    fill_in "Улица", with: listing.street
    select("Alabama", from: "Штат")
    select("Abbeville", from: "Город")
    check("Активно")

    click_on "Сохранить"

    expect(page).to have_content I18n.t(:post_created)
    saved_listing = Listing.last

    expect(saved_listing.kind).to eq "services"
    expect(saved_listing.category).to eq listing.category
    expect(saved_listing.subcategory).to eq listing.subcategory
    expect(saved_listing.title).to eq listing.title
    expect(saved_listing.text).to eq listing.text
    expect(saved_listing.phone).to eq listing.phone
    expect(saved_listing.street).to eq listing.street
    expect(saved_listing.state.name).to eq "Alabama"
    expect(saved_listing.city.name).to eq "Abbeville"
  end

  scenario "user creates sale", js: true do
    create_and_login_user

    visit new_dashboard_listing_path
    listing = build :listing, :sale

    find("option[value='#{listing.kind}']").select_option
    find("option[value='#{listing.category}']").select_option
    find("option[value='#{listing.subcategory}']").select_option

    fill_in "Заголовок", with: listing.title
    fill_in "Описание", with: listing.text
    fill_in "Телефон", with: listing.phone

    fill_in "Улица", with: listing.street
    select("Alabama", from: "Штат")
    select("Abbeville", from: "Город")
    check("Активно")

    click_on "Сохранить"

    expect(page).to have_content I18n.t(:post_created)
    saved_listing = Listing.last
    expect(saved_listing.kind).to eq "sales"
    expect(saved_listing.category).to eq listing.category
    expect(saved_listing.subcategory).to eq listing.subcategory
    expect(saved_listing.title).to eq listing.title
    expect(saved_listing.text).to eq listing.text
    expect(saved_listing.phone).to eq listing.phone
    expect(saved_listing.street).to eq listing.street
    expect(saved_listing.state.name).to eq "Alabama"
    expect(saved_listing.city.name).to eq "Abbeville"
  end
end
