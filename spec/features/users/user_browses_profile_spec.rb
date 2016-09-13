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
    re_private = create :re_private, user: user
    re_private.create_entry(user: user)

    visit user_path(user)
    first(:link, "Объявления").click
    expect(page).to have_content re_private.title
  end

  scenario "visits answers" do
    user = create :user
    q = create :question
    answer = create :answer, user: user, question: q, title: q.title

    visit user_path(user)
    first(:link, "Ответы").click
    expect(page).to have_content answer.title
  end

  scenario "visits his own profile" do
    user = create_and_login_user

    visit user_path(user)

    expect(page).to have_content "Настройки"
  end
end
