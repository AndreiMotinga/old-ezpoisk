require "rails_helper"

describe User do
  it { should have_many(:pictures).dependent(:destroy) }
  it { should have_many(:listings).dependent(:destroy) }
  it { should belong_to(:city) }
  it { should belong_to(:state) }

  it { should have_many(:questions) }
  it { should have_many(:answers) }
  it { should have_many(:reviews) }
  it { should have_many(:comments) }

  it { should validate_presence_of(:email) }

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

    it "notifies slack" do
      allow(UserMailerJob).to receive(:perform_async)

      user = create :user

      expect(UserMailerJob)
        .to have_received(:perform_async).with(user.id)
    end
  end

  describe "#name_to_show" do
    it "returns name if name is present" do
      user = create :user, name: "me"
      expect(user.name_to_show).to eq "me"
    end

    it "returns emails if name isn't present" do
      user = create :user, name: ""
      expect(user.name_to_show).to eq user.email
    end
  end

  describe "#editor?" do
    it "returns true if user is editor or admin" do
      admin = create :user, admin: true
      editor = create :user, role: "editor"
      regular = create :user
      expect(admin.editor?).to eq true
      expect(editor.editor?).to eq true
      expect(regular.editor?).to eq false
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

  describe "#address" do
    it "has an address" do
      record = create(:user,
                      street: "1970 East 18th str",
                      state_id: 33,
                      city_id: 18_033,
                      zip: 11_229)

      expect(record.address).to eq("1970 East 18th str Brooklyn New York 11229")
    end
  end
end
