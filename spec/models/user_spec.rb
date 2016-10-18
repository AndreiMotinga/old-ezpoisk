require 'rails_helper'

describe User do
  it { should have_many(:re_privates).dependent(:destroy) }
  it { should have_many(:jobs).dependent(:destroy) }
  it { should have_many(:services).dependent(:destroy) }
  it { should have_many(:stripe_subscriptions) }
  it { should have_many(:sales).dependent(:destroy) }
  it { should have_many(:pictures).dependent(:destroy) }
  it { should have_many(:posts) }
  it { should have_many(:entries) }

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
