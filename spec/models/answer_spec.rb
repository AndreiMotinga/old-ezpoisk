require "rails_helper"

describe Answer do
  it { should belong_to(:user) }
  it { should belong_to(:question) }

  describe ".week" do
    it "returns amount of answers created during current week" do
      create(:answer, created_at: Time.current)
      create(:answer, created_at: 8.days.ago)

      result = Answer.week.size

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

  describe "#avatar" do
    it "returns author's avatar" do
      answer = build(:answer)
      url = "www.google.com/images/foo"
      user = double(:user)
      allow(answer).to receive(:user).and_return(user)
      allow(user)
        .to receive(:avatar)
        .with(:thumb)
        .and_return(url)

      result = answer.avatar

      expect(result).to eq url
      expect(user).to have_received(:avatar).with(:thumb)
    end
  end
end
