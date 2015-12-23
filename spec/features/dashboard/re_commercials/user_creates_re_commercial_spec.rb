require "rails_helper"

feature "User create re_commercial" do
  scenario "success", js: true do
    user = create :user
    login_as(user, scope: :user)
    re_commercial = build(:re_commercial)
    state = State.create(name: "Alabama")
    City.create(name: "Abbeville", state: state)

    visit new_dashboard_re_commercial_path
    fill_in :Street, with: re_commercial.street
    fill_in :Phone, with: re_commercial.phone
    fill_in :Price, with: re_commercial.price
    fill_in :Space, with: re_commercial.space
    fill_in :Description, with: re_commercial.description
    select("Аренда", from: "Post type")
    select("Alabama", from: :State)
    select("Abbeville", from: :City)
    select("office", from: :Category)
    check(:Active)
    click_on "Create Re commercial"

    expect(page).to have_content re_commercial.street
    expect(page).to have_content re_commercial.phone
    expect(page).to have_content re_commercial.price
    expect(page).to have_content re_commercial.space
    expect(page).to have_content re_commercial.space
    expect(page).to have_content re_commercial.description
    expect(page).to have_content "Аренда"
    expect(page).to have_content "Alabama"
    expect(page).to have_content "Abbeville"
    expect(page).to have_content "office"
    expect(page).to have_content "true"
    expect(ReCommercial.last.user).to eq user
  end
end
