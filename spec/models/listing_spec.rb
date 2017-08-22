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

  describe "#answers" do
    it "returns answers with same tags" do
      l = create :listing, :apartment
      a = create :answer, tag_list: ["недвижимость"]
      create :answer, tag_list: ["работа"]

      expect(l.answers).to match_array [a]
    end
  end

  # PRIVATE

  describe "private ensure_title" do
    context "title exits" do
      it "does nothing" do
        title = "Foo bar baz"
        listing = build :listing, title: title

        listing.save
        listing.reload

        expect(listing.title).to eq title
      end
    end

    context "title doesn't exit" do
      it "generates title from Media::Title" do
        title = "Foo bar baz"
        listing = build :listing, title: nil
        allow(Media::Title).to receive(:of).with(listing.text).and_return(title)

        listing.save
        listing.reload

        expect(listing.title).to eq title
        expect(Media::Title).to have_received(:of).with(listing.text)
      end
    end
  end

  describe "private format site" do
    context "there is no site" do
      it "does nothing" do
        listing = build :listing, site: ""

        listing.save
        listing.reload

        expect(listing.site).to eq ""
      end
    end

    context "doesn't have http" do
      it "prepends http" do
        listing = build :listing, site: "www.ezpoisk.com"

        listing.save
        listing.reload

        expect(listing.site).to eq "http://www.ezpoisk.com"
      end
    end

    context "has http" do
      it "does nothing" do
        listing = build :listing, site: "http://www.ezpoisk.com"

        listing.save
        listing.reload

        expect(listing.site).to eq "http://www.ezpoisk.com"
      end
    end
  end

  describe "private set_tags" do
    it "saves tag_list" do
      l = build :listing, subcategory: "foo"
      l.save
      result = [l.kind, l.category, l.subcategory, l.state.slug, l.city.slug]
      expect(l.tag_list).to match_array result
    end

    it "splits subcategories" do
      l = build :listing, subcategory: "продавцы--кассиры--администраторы"

      l.save
      result = [l.kind, l.category, l.state.slug, l.city.slug, "продавцы",
                "кассиры", "администраторы"]

      expect(l.tag_list).to match_array result
    end
  end
end
