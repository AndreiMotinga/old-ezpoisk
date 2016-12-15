require "rails_helper"

RSpec.describe Listing, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:city) }
  it { should belong_to(:state) }
  it { should have_many(:pictures).dependent(:destroy) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_least(5) }
  it { should validate_length_of(:title).is_at_most(70) }
  it { should validate_presence_of(:kind) }
  it { should validate_presence_of(:category) }
  it { should validate_presence_of(:subcategory) }
  it { should validate_presence_of(:text) }
  it { should validate_length_of(:text).is_at_least(10) }

  it "validates source" do
    listing = Listing.new

    listing.valid?

    message = "Добавьте телефон, email, ссылку на vkontakte или facebook"
    expect(listing.errors[:phone]).to include(message)
  end

  context "Mappable" do
    describe "#address" do
      it "has an address" do
        record = create(:listing,
                        street: "1970 East 18th str",
                        state_id: 33,
                        city_id: 18_033,
                        zip: 11_229)

        expect(record.address).to eq("1970 East 18th str Brooklyn New York 11229")
      end
    end

    describe "infowindow" do
      it "returns infowindow string" do
        record = create(:listing,
                        street: "1970 East 18th str",
                        state_id: 33,
                        city_id: 18_033,
                        zip: 11_229)
        address = "1970 East 18th str Brooklyn New York 11229"
        string = "<a href='https://maps.google.com/?q=#{address}'  rel='nofollow' target='blank'>#{address}</a>"
        expect(record.infowindow).to eq string
      end
    end

    describe "map_marker" do
      it "return map_marker" do
        record = create(:listing,
                        street: "1970 East 18th str",
                        state_id: 33,
                        city_id: 18_033,
                        zip: 11_229)

        expect(record.map_marker).to_not eq nil
      end
    end
  end
end
