require "rails_helper"

feature "User browses questions" do
  scenario "success" do
    user = create(:user)
    question = create :question
    create :answer, question: question, user: user

    visit questions_path

    expect(page).to have_content question.title
  end
end

feature "User browses question" do
  scenario "success when user logged in" do
    create_and_login_user
    q = create :question
    user = create(:user)
    a = create :answer, question: q, user: user

    visit question_path(q)

    expect(page).to have_content q.title
  end
end
