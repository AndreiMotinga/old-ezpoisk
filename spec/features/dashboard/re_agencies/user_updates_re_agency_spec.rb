require "rails_helper"

feature "user updates re_agency" do
  scenario "updates details", js: true do
    create_alabama_and_abbeville
    user = create_and_login_user

    re_agency = create :re_agency, user: user

    visit edit_dashboard_re_agency_path re_agency
    fill_in "Название", with: "New title"
    fill_in "Улица", with: "New street"
    fill_in "Телефон", with: "999 999 999"
    fill_in :Email, with: "some@gmail.com"
    fill_in "Сайт", with: "www.example.com"
    select("Alabama", from: "Штат")
    select("Abbeville", from: "Город")
    uncheck("Активно")

    click_on "details-save-btn"

    expect(page).to have_content I18n.t(:post_saved)
    re_agency.reload

    expect(re_agency.title).to eq "New title"
    expect(re_agency.street).to eq "New street"
    expect(re_agency.phone).to eq "999 999 999"
    expect(re_agency.email).to eq "some@gmail.com"
    expect(re_agency.site).to eq "www.example.com"
    expect(re_agency.active).to eq false

    expect(re_agency.state.name).to eq "Alabama"
    expect(re_agency.city.name).to eq "Abbeville"
  end

  scenario "updates description" do
    user = create_and_login_user
    re_agency = create :re_agency, user: user

    visit edit_dashboard_re_agency_path re_agency
    fill_in "Описание", with: "New description"
    click_on "description-save-btn"
    re_agency.reload

    expect(re_agency.description).to eq "New description"
  end
end
