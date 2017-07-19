# replace with view/request spec
require "rails_helper"

feature "User browses profile" do
  scenario "visits page" do
    user = create :user

    visit profile_path(user)
    expect(page).to have_content user.name
    expect(page).to have_content user.about
  end

  scenario "visits listings" do
    user = create :user
    listing = create :listing, user: user

    visit profile_path(user)
    first(:link, "Объявления").click

    expect(page).to have_content listing.title
  end

  scenario "visits answers" do
    user = create :user
    q = create :question
    answer = create :answer, user: user, question: q, title: q.title

    visit profile_path(user)
    first(:link, "Ответы").click
    expect(page).to have_content answer.title
  end
end
