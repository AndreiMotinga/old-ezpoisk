require "rails_helper"

describe Partner do
  it { should validate_presence_of :title }
  it { should validate_presence_of :image }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:budget) }
  it { should validate_presence_of(:email) }
  it { should belong_to(:user) }

  describe "#random" do
    it "returns featured first" do
      create :partner, position: "left"
      featured = create :partner, position: "left", featured: true
      create :partner, position: "left"

      first = Partner.random("left", 2).first
      expect(first).to eq featured
    end
  end
end
