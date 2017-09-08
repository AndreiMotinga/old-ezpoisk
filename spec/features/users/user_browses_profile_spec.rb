# replace with view/request spec
require "rails_helper"

feature "User browses profile" do
  scenario "visits page" do
    user = create :user, id: 10

    visit user_path(user)

    expect(page).to have_content user.name
    expect(page).to have_content user.about
  end

  scenario "visits listings" do
    user = create :user, id: 10
    listing = create :listing, user: user

    visit listings_user_path(user)

    prm = listing.kind == "услуги" ? :title : :text
    expect(page).to have_content listing.send(prm)
  end

  scenario "visits answers" do
    user = create :user, id: (rand * 100).round

    q = create :question
    answer = create :answer, user: user, question: q, title: q.title

    visit user_path(user)
    first(:link, "Ответы").click
    expect(page).to have_content answer.title
  end

  scenario "visits questions" do
    user = create :user, id: 10
    q = create :question, user: user

    visit questions_user_path(user)
    first(:link, "Вопросы").click

    expect(page).to have_content q.title
  end

  scenario "visits posts" do
    user = create :user, id: 10
    q = create :question, user: user

    visit posts_user_path(user)
    first(:link, "Вопросы").click

    expect(page).to have_content q.title
  end
end
