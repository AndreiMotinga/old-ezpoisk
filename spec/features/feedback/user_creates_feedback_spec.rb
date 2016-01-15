require "rails_helper"

feature "Feedback" do
  scenario "User is no logged in" do
    create :post, important: true
    visit new_feedback_path
    fill_in "Ваше имя", with: "Andrei"
    fill_in "email", with: "test@test.com"
    fill_in "Сообщение", with: "my feedback here"
    click_on "Оставить отзыв"

    expect(page).to have_content I18n.t(:thanks_for_feedback)
    feedback = Feedback.last
    expect(feedback.name).to eq "Andrei"
    expect(feedback.email).to eq "test@test.com"
    expect(feedback.body).to eq "my feedback here"
  end
end
