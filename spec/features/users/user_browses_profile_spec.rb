# replace with view/request spec
require "rails_helper"

feature "User browses profile" do
  scenario "visits page" do
    user = create :user

    visit user_path(user)
    expect(page).to have_content user.name
    expect(page).to have_content user.about
  end

  scenario "visits posts" do
    user = create :user
    news_post = create :post, user: user

    visit user_path(user)
    first(:link, "Новости").click
    expect(page).to have_content news_post.title
  end

  scenario "visits listings" do
    user = create :user
    listing = create :listing, user: user

    visit user_path(user)
    first(:link, "Объявления").click

    expect(page).to have_content listing.title
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
