require "rails_helper"

describe User do
  it { should have_many(:images).dependent(:destroy) }
  it { should have_many(:listings).dependent(:destroy) }

  it { should have_many(:questions) }
  it { should have_many(:answers) }
  it { should have_many(:reviews) }
  it { should have_many(:comments) }
  it { should have_many(:karmas) }

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

  describe "#run_notifications" do
    it "notifies slack" do
      allow(SlackNotifierJob).to receive(:perform_async)

      user = create :user

      expect(SlackNotifierJob)
        .to have_received(:perform_async).with(user.id, "User")
    end
  end

  describe "#can_edit?" do
    it "returns true if user is recrod's owner or is admin" do
      owner = create :user
      regular = create :user
      admin = create :user, admin: true
      record = create :listing, user: owner

      expect(owner.can_edit?(record)).to eq true
      expect(admin.can_edit?(record)).to eq true
      expect(regular.can_edit?(record)).to eq false
    end
  end

  describe "#member?" do
    it "returns true if user is member of the team" do
      admin = create :user, admin: true
      editor = create :user, role: "editor"
      joe = create :user

      expect(admin.member?).to eq true
      expect(editor.member?).to eq true
      expect(joe.member?).to eq false
    end
  end

  describe ".with_parthers" do
    it "returns ids of users who have active partners"
    it "orders ids by partners.impressions_count asc"
    it "returns ids of users with partners of correct kind"
    it "returns distinct ids"
  end
end
