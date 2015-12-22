require "rails_helper"

feature "user creates re_private" do
  scenario "successfully", js: true do
    re_private = create :re_private
    updated_re_private = build :re_private
    state = State.create(name: "Alabama")
    City.create(name: "Abbeville", state: state)
    user = create :user
    login_as(user, scope: :user)

    visit edit_dashboard_re_private_path re_private
    fill_in :Street, with: updated_re_private.street
    select("Аренда", from: "Post type")
    select("Месяц", from: :Duration)
    fill_in :Apt, with: updated_re_private.apt
    fill_in :Phone, with: updated_re_private.phone
    fill_in :Price, with: updated_re_private.price
    fill_in :Baths, with: updated_re_private.baths
    fill_in :Space, with: updated_re_private.space
    fill_in :Rooms, with: updated_re_private.rooms
    fill_in :Description, with: updated_re_private.description
    check(:Active)
    check(:Fee)
    select("Alabama", from: :State)
    select("Abbeville", from: :City)
    click_on "Update Re private"

    expect(page).to have_content updated_re_private.street
  end
end
