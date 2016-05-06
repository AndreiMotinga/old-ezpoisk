require "rails_helper"

feature "User browses profile" do
  scenario "visits personal info (contacts)" do
    user = create :user
    profile = create :profile, user: user

    visit profile_path(profile)
    expect(page).to have_content profile.name
    expect(page).to have_content profile.motto
    expect(page).to have_content profile.about
    expect(page).to have_content profile.work
  end

  scenario "visits posts" do
    user = create :user
    profile = create :profile, user: user
    news_post = create :post, user: user

    visit profile_posts_path(profile)
    expect(page).to have_content news_post.title
  end

  scenario "visits listings" do
    user = create :user
    profile = create :profile, user: user
    re_private = create :re_private, user: user

    visit profile_listings_path(profile)
    expect(page).to have_content re_private.title
  end

  scenario "visits answers" do
    user = create :user
    profile = create :profile, user: user
    q = create :question
    answer = create :answer, user: user, question: q

    visit profile_answers_path(profile)
    expect(page).to have_content answer.question_title
  end

  scenario "visits his own profile" do
    user = create_and_login_user
    profile = create :profile, user: user

    visit profile_path(profile)
    expect(page).to have_content "Редактировать"
  end
end
