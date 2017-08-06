require "rails_helper"

RSpec.describe Listing, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:city) }
  it { should belong_to(:state) }
  it { should have_many(:pictures).dependent(:destroy) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
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
                        state_id: 32,
                        city_id: 18_031,
                        zip: 11_229)

        expect(record.address).to eq("1970 East 18th str Brooklyn New York 11229")
      end
    end

    describe "infowindow" do
      it "returns infowindow string" do
        record = create(:listing,
                        street: "1970 East 18th str",
                        state_id: 32,
                        city_id: 18_031,
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
                        state_id: 32,
                        city_id: 18_031,
                        zip: 11_229)

        expect(record.map_marker).to_not eq nil
      end
    end
  end

  xdescribe ".to_deactivate" do
    it "returns active listings that weren't edited more than 30 days" do
      create_list :listing, 5, updated_at: 31.days.ago
      create :listing, active: false, updated_at: 31.days.ago
      create :listing
      expect(Listing.to_deactivate.size).to eq 5
    end

    it "doesn't include services" do
      create_list :listing, 5, :apartment, updated_at: 31.days.ago
      create :listing, :service
      expect(Listing.to_deactivate.size).to eq 5
    end
  end
end
