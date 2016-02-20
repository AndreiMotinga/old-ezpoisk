require "rails_helper"

feature "user updates question" do
  scenario "updates details", js: true do
    user = create_and_login_user
    question = create :question, user: user

    visit edit_question_path(question)
    fill_in "Ваш вопрос", with: "New title"
    click_on "Сохранить"

    expect(page).to have_content I18n.t(:q_updated)

    question.reload
    expect(question.title).to eq "New title"
  end
end
