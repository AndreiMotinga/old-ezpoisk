require "rails_helper"

feature "Feedback" do
  context "via contact us page" do
    scenario "User is no logged in" do
      create :post, main: true
      visit new_feedback_path
      fill_in "feedback-name", with: "Andrei"
      fill_in "feedback-email", with: "test@test.com"
      fill_in "feedback-body", with: "my feedback here"
      click_on "feedback-submit"

      expect(page).to have_content I18n.t(:thanks_for_feedback)
      feedback = Feedback.last
      expect(feedback.name).to eq "Andrei"
      expect(feedback.email).to eq "test@test.com"
      expect(feedback.body).to eq "my feedback here"
    end

    scenario "User is logged in" do
      user = create_and_login_user
      create :post, main: true
      visit new_feedback_path
      fill_in "feedback-body", with: "my feedback here"
      click_on "feedback-submit"

      expect(page).to have_content I18n.t(:thanks_for_feedback)
      feedback = Feedback.last
      expect(feedback.user).to eq user
      expect(feedback.name).to eq user.name
      expect(feedback.email).to eq user.email
      expect(feedback.body).to eq "my feedback here"
    end
  end
end
