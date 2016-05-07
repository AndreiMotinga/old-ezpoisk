require "rails_helper"

describe Profile do
  it { should belong_to(:user) }
  it { should belong_to(:state) }
  it { should belong_to(:city) }

  it { should have_many(:posts) }
  it { should have_many(:answers) }

  describe "#email" do
    it "returns user's email" do
      user = create :user
      profile = Profile.first

      expect(profile.user_email).to eq user.email
    end
  end
end
