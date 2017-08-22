require "rails_helper"

RSpec.describe Partner, type: :model do
  it { should belong_to(:user) }

  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_most(45) }
  it { should validate_presence_of(:final_url) }
  it { should validate_presence_of(:headline) }

  describe ".state" do
    it "returns partners for state and without state" do
      first = create :partner, title: "first", state_id: 32
      second = create :partner, title: "second", state_id: nil
      create :partner, state_id: 9

      result = Partner.state("new-york").pluck :title
      expected = [first, second].map(&:title)

      expect(result).to match_array expected
    end
  end

  describe ".city" do
    it "returns partners for city and without city" do
      first = create :partner, title: "first", city_id: 18031
      second = create :partner, title: "second", city_id: nil
      create :partner, city_id: 3964

      result = Partner.city("brooklyn").pluck :title
      expected = [first, second].map(&:title)

      expect(result).to match_array expected
    end
  end

  describe ".by_tags" do
    it "returns partners by tags and those without tags" do
      with = create :partner, title: "работа", tag_list: ["работа"]
      without = create :partner, title: "dummy", tag_list: []
      create :partner, tag_list: ["услуги"]

      result = Partner.by_tags(["работа"]).pluck(:title)
      expected = [with, without].map(&:title)

      expect(result).to match_array expected
    end
  end

  describe ".by_ctr" do
    it "returns partners width distinct users by max ctr" do
      create :partner, cached_ctr: 1.0
      first = create :partner, cached_ctr: 20.0
      create :partner, user: first.user, cached_ctr: 10.0

      result = Partner.by_ctr.pluck(:cached_ctr)

      expect(result).to match_array [20.0, 1.0]
    end
  end

  # PRIVATE

  describe "private set_random_cached_ctr" do
    context "ctr is null" do
      it "generates random ctr" do
        partner = create :partner

        expect(partner.cached_ctr).to_not be nil
      end
    end

    context "cached_ctr provided" do
      it "does nothing" do
        partner = create :partner, cached_ctr: 20

        expect(partner.cached_ctr).to eq 20
      end
    end
  end
end
