require "rails_helper"

feature "Voting on answers" do
  context "user logged in" do
    scenario "user upvotes answer", js: true do
      user = create_and_login_user
      answer = create(:answer, user: user)

      visit answer_path(answer)
      click_on "Upvote"
      wait_for_ajax
      answer.reload

      expect(page).to have_content("Voted | 1")
      expect(answer.score).to eq 1
    end

    scenario "user downvotes answer", js: true do
      user = create_and_login_user
      answer = create(:answer, user: user)

      visit answer_path(answer)
      click_on "Downvote"
      wait_for_ajax
      answer.reload

      expect(page).to have_content("Voted | -1")
      expect(answer.score).to eq(-1)
    end
  end
end
