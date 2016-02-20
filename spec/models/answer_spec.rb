require "rails_helper"

describe Answer do
  it { should belong_to(:user) }
  it { should belong_to(:question) }

  describe ".the_answer" do
    it "returns best answer" do
      user = create :user
      question = create :question
      bad = create :answer, question: question
      good = create :answer, question: question
      good.upvote_by user

      expect(Answer.the_answer).to eq good
    end
  end
end
