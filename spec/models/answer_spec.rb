require "rails_helper"

describe Answer do
  it { should belong_to(:user) }
  it { should belong_to(:question) }

  describe ".this_week" do
    it "returns amount of answers created during current week" do
      create(:answer, created_at: Date.current)
      create(:answer, created_at: 1.week.ago)

      result = Answer.this_week

      expect(result).to eq 1
    end
  end

  describe ".score" do
    it "returns upvotes minues downvotes" do
      answer = build(:answer)
      allow(answer)
        .to receive_message_chain(:get_upvotes, :count)
        .and_return(4)
      allow(answer)
        .to receive_message_chain(:get_downvotes, :count)
        .and_return(1)

      result = answer.score

      expect(result).to eq 3
    end
  end
end
