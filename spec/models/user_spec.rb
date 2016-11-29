require 'rails_helper'

describe User do
  it { should have_many(:pictures).dependent(:destroy) }
  it { should have_many(:listings).dependent(:destroy) }

  describe "#online?" do
    it "true if user last seen less than 5 min ago" do
      user = create :user, last_seen: 2.minutes.ago
      expect(user.online?).to eq true
    end

    it "false if user last seen more than 5 min ago" do
      user = create :user, last_seen: 10.minutes.ago
      expect(user.online?).to eq false
    end
  end
end
