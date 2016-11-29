require "rails_helper"

RSpec.describe Listing, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:city) }
  it { should belong_to(:state) }
  it { should have_many(:pictures).dependent(:destroy) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }

  it "validates source" do
    listing = Listing.new

    listing.valid?

    message = "Добавьте телефон, email, ссылку на vk или fb"
    expect(listing.errors[:phone]).to include(message)
  end
end
