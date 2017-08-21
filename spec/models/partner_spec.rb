require "rails_helper"

RSpec.describe Partner, type: :model do
  it { should belong_to(:user) }

  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_most(45) }
  it { should validate_presence_of(:final_url) }
  it { should validate_presence_of(:headline) }

  describe ".get" do
    context "default" do
      it "returns partners with state, city and tags unspecified" do
        partner = create :partner, title: "state", state: nil, city: nil, tag_list: []
        create :partner, state_id: 32, city_id: 18031, tag_list: ["работа"]

        result = Partner.get

        expect(result.size).to eq 1
        expect(result.first).to eq partner
      end
    end

    context "by state" do
      it "returns partners for state and without state" do
        first = create :partner, title: "first", state_id: 32
        second = create :partner, title: "second", state_id: nil
        create :partner, state_id: 9

        result = Partner.get(state: "new-york").pluck :title
        expected = [first, second].map(&:title)

        expect(result).to match_array expected
      end
    end

    context "by city" do
      context "city is always linked to state" do
        it "returns partners by state, where city_id is id or nil" do
          first = create :partner, title: "first", state_id: 32, city_id: 18031
          second = create :partner, title: "second", state_id: 32, city_id: nil
          create :partner, city_id: 3964

          result = Partner.get(state: "new-york", city: "brooklyn").pluck :title
          expected = [first, second].map(&:title)

          expect(result).to match_array expected
        end
      end
    end

    context "by tags" do
      it "returns partners by tags and those without tags" do
        with = create :partner, title: "работа", tag_list: ["работа"]
        without = create :partner, title: "dummy", tag_list: []
        create :partner, tag_list: ["услуги"]

        result = Partner.get(tags: ["работа"]).pluck(:title)
        expected = [with, without].map(&:title)

        expect(result).to match_array expected
      end
    end
  end
end
