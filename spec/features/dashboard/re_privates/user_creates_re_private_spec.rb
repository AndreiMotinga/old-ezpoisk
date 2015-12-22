require "rails_helper"

feature "User create re_private" do
  scenario "success", js: true do
    user = create :user
    login_as(user, scope: :user)
    re_private = build(:re_private)
    state = State.create(name: "Alabama")
    City.create(name: "Abbeville", state: state)

    visit new_dashboard_re_private_path
    fill_in :Street, with: re_private.street
    select("Аренда", from: "Post type")
    select("Месяц", from: :Duration)
    fill_in :Apt, with: re_private.apt
    fill_in :Phone, with: re_private.phone
    fill_in :Price, with: re_private.price
    fill_in :Baths, with: re_private.baths
    fill_in :Space, with: re_private.space
    fill_in :Rooms, with: re_private.rooms
    fill_in :Description, with: re_private.description
    check(:Active)
    check(:Fee)
    select("Alabama", from: :State)
    select("Abbeville", from: :City)
    click_on "Create Re private"

    expect(page).to have_content re_private.street
    expect(page).to have_content "Alabama"
    expect(page).to have_content "Abbeville"
    expect(RePrivate.count).to be 1
  end
end
