# replace with view/request spec
require "rails_helper"

feature "User browses profile" do
  scenario "visits page" do
    user = create :user

    visit user_path(user)
    expect(page).to have_content user.name
    expect(page).to have_content user.about
  end

  scenario "visits listings" do
    user = create :user
    listing = create :listing, kind: "недвижимость", user: user

    visit listings_user_path(user)

    expect(page).to have_content listing.category
  end

  scenario "visits answers" do
    user = create :user
    q = create :question
    answer = create :answer, user: user, question: q, title: q.title

    visit user_path(user)
    first(:link, "Ответы").click
    expect(page).to have_content answer.title
  end
end
