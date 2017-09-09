require "rails_helper"

RSpec.describe Partner, type: :model do
  it { should belong_to(:user) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:final_url) }
  it { should validate_presence_of(:headline) }
  it { should validate_length_of(:headline).is_at_most(50) }
  it { should validate_length_of(:subline).is_at_most(50) }
  it { should validate_length_of(:text).is_at_most(160) }

  describe ".side" do
    it "retrieves partners for different users ordered by impressions_count" do
      names = %w(ez agir alfa)
      names.each do |name|
        user = create :user, name: name
        create_list :partner, 2,
                    user: user,
                    title: user.name,
                    kind: "side",
                    impressions_count: 0
        create :partner, user: user, kind: "side", impressions_count: 10
      end

      result = Partner.side
      users = result.map { |p| p.user.name }
      titles = result.pluck(:title)

      expect(users).to match_array names
      expect(titles).to match_array names
    end
  end

  describe ".by_state" do
    it "return parnter by state" do
      partner = create :partner, state_id: 32
      create :partner, state_id: 1

      result = Partner.by_state("new-york")

      expect(result.size).to eq 1
      expect(result.first).to eq partner
    end

    it "returns partners where state isn't set" do
      create :partner, state_id: 32
      create :partner, state_id: nil

      expect(Partner.by_state("new-york").count).to eq 2
    end
  end

  describe ".by_city" do
    it "returns partners for city" do
      partner = create :partner, city_id: 18031
      create :partner, city_id: 3964

      result = Partner.by_city("brooklyn")

      expect(result.size).to eq 1
      expect(result.first).to eq partner
    end

    it "returns partners without city" do
      create :partner, city_id: 18031
      create :partner, city_id: nil

      expect(Partner.by_city("brooklyn").count).to eq 2
    end
  end

  describe ".by_tags" do
    it "returns partners by tags" do
      create :partner, tag_list: ["работа", "недвижимость"]
      create :partner

      expect(Partner.by_tags(["работа", "услуги"]).count).to eq 1
    end
  end

  describe ".inline" do
    it "orders by impressions_count before shuffle" do
      create :partner, title: "second", kind: "inline", impressions_count: 5
      create :partner, title: "third", kind: "inline", impressions_count: 8
      create :partner, title: "first", kind: "inline", impressions_count: 2
      stub_inline_filtering(Partner.active)

      result = Partner.inline(2).pluck(:title)

      expect(result).to match_array %w[first second]
    end

    context "limit is 3" do
      it "returns one item" do
        create_list :partner, 5, kind: "inline"
        stub_inline_filtering(Partner.active)

        result = Partner.inline(5)

        expect(result.size).to eq 5
      end
    end

    it "returns partners for different users" do
      names = %w(ez agir alfa)
      names.each do |name|
        user = create :user, name: name
        create_list :partner, 2,
                    user: user,
                    title: user.name,
                    kind: "inline",
                    impressions_count: 0
        create :partner, user: user, kind: "inline", impressions_count: 10
      end
      stub_inline_filtering(Partner.active)

      result = Partner.inline(3)
      users = result.map { |p| p.user.name }
      titles = result.pluck(:title)

      expect(users).to match_array names
      expect(titles).to match_array names
    end

    it "returns ez if result is empty" do
      stub_inline_filtering(Partner.active)
      create :partner, final_url: "ezpoisk.com/реклама"

      result = Partner.inline(3, { tags: "работа" })

      expect(result.size).to eq 1
      expect(result.first.final_url).to eq "ezpoisk.com/реклама"
    end

    it "write test without stubbing just to make sure"
  end


  def stub_inline_filtering(return_val)
    %i[by_state by_city by_tags].each do |method|
      allow(Partner).to receive(method).and_return(return_val)
    end
  end
end
