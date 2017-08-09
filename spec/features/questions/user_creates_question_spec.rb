require "rails_helper"

feature "user creates question" do
  scenario "successfully", js: true do
    user = create_and_login_user
    attrs = build :question

    visit new_question_path
    fill_in "Ваш вопрос", with: attrs.title
    fill_in "Подробности", with: attrs.text
    select3("недвижимость")
    select3("работа")
    click_on "Сохранить"

    expect(page).to have_content I18n.t(:q_created)
    question = user.questions.last
    expect(question.title).to eq attrs.title
    expect(question.text).to eq attrs.text
    expect(question.slug).not_to be_empty
    expect(question.cached_tags).to eq "недвижимость,работа"
  end
end
