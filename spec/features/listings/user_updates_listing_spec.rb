require "rails_helper"

feature "user creates listing" do
  before do
    @user = create_and_login_user
    @listing = create :listing, user: @user
    @attrs = build :listing, kind: @listing.kind
  end

  scenario "successfully", js: true do
    visit edit_listing_path(@listing)

    case @attrs.kind
    when "недвижимость" then fill_re
    when "продажи" then fill_sale
    when "услуги" then fill_service
    end
    fill_general
    fill_contacts
    save_and_open_page
    click_on "Сохранить"

    expect(page).to_not have_content "Раздел"
    expect(page).to have_content I18n.t(:post_saved)
    @listing.reload
    expect(@listing.user).to eq @user
    expect(@listing.kind).to eq @attrs.kind
    expect(@listing.category).to eq @attrs.category
    expect(@listing.subcategory).to eq @attrs.subcategory
    expect(@listing.text).to eq @attrs.text
    expect(@listing.phone).to eq @attrs.phone
    expect(@listing.email).to eq @attrs.email
    expect(@listing.vk).to eq @attrs.vk
    expect(@listing.fb).to eq @attrs.fb
    expect(@listing.gl).to eq @attrs.gl
    expect(@listing.site).to eq @attrs.site
    expect(@listing.street).to eq @attrs.street
    expect(@listing.state.name).to eq "Arizona"
    expect(@listing.city.name).to eq "Phoenix"

    case @attrs.kind
    when "недвижимость" then re_expecs
    when "продажи" then sale_expecs
    when "услуги" then service_expecs
    end
  end

  def sale_expecs
    expect(@listing.price).to eq @attrs.price
  end

  def re_expecs
    expect(@listing.price).to eq @attrs.price
    expect(@listing.duration).to eq @attrs.duration
    expect(@listing.baths).to eq @attrs.baths
  end

  def service_expecs
    expect(@listing.title).to eq @attrs.title
  end

  def fill_sale
    fill_in "Цена", with: @attrs.price
  end

  def fill_service
    fill_in "Заголовок", with: @attrs.title
  end

  def fill_re
    find("option[value='#{@attrs.rooms}']").select_option
    fill_in "Цена", with: @attrs.price
    find("option[value='#{@attrs.duration}']").select_option
    fill_in "Ванные", with: @attrs.baths
  end

  def fill_general
    fill_in "Описание", with: @attrs.text
    find("option[value='#{@attrs.category}']").select_option
    find("option[value='#{@attrs.subcategory}']").select_option
  end

  def fill_contacts
    fill_in "Телефон", with: @attrs.phone
    fill_in "Email", with: @attrs.email
    fill_in "Я vkontakte", with: @attrs.vk
    fill_in "Я в facebook", with: @attrs.fb
    fill_in "Я в google+", with: @attrs.gl
    fill_in "Я online (website)", with: @attrs.site
    fill_in "Улица", with: @attrs.street
    select("Arizona", from: "Штат")
    select("Phoenix", from: "Город")
  end
end
