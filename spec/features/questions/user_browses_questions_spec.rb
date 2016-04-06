require "rails_helper"

feature "User browses questions" do
  scenario "success" do
    question = create :question
    create :answer, question: question

    visit questions_path

    expect(page).to have_content question.title
  end
end

feature "User browses question" do
  scenario "success when user logged in" do
    create_and_login_user
    q = create :question
    a = create :answer, question: q

    visit question_path(q)

    expect(page).to have_content q.title
    expect(page).to have_content a.text
  end
end

