require "rails_helper"

describe Partner do
  it { should validate_presence_of :title }
  it { should validate_presence_of :state_id }
  it { should belong_to(:user) }
  it { should belong_to(:state) }

  describe ".active" do
    it "returns only active partners" do
      create :partner, active: false
      active = create :partner

      expect(Partner.active).to eq [active]
    end
  end

  describe ".with_balance" do
    it "returns only partners where current_balance < budget" do
      p = create :partner, budget: 1000, current_balance: 0
      create :partner, budget: 1000, current_balance: 1001

      expect(Partner.with_balance).to eq [p]
    end
  end

  describe ".by_position" do
    it "return partners of certain position" do
      top = create :partner, position: :top
      bottom = create :partner, position: :bottom
      side = create :partner, position: :side

      expect(Partner.by_position(:top)).to eq [top]
      expect(Partner.by_position(:bottom)).to eq [bottom]
      expect(Partner.by_position(:side)).to eq [side]
    end
  end

  describe ".by_bid" do
    it "sorts partners by bids highest first" do
      create :partner, bid: 5
      create :partner, bid: 10
      create :partner, bid: 1

      expect(Partner.by_bid.pluck(:bid)).to eq [10, 5, 1]
    end
  end

  describe ".by_state" do
    it "returns partners by state" do
      state = create :state
      partner = create :partner, state: state
      create :partner, state: create(:state)

      expect(Partner.by_state(state.id).size).to eq 1
      expect(Partner.by_state(state.id).first).to eq partner
    end
  end

  describe ".filter" do
    it "return correct partner" do
      state = create(:state)
      city = create :city, state: state
      page = create :page
      position = :top
      partner = create(:partner, bid: 10, position: position, state: state,
                       page_list: [page.title])
      create :partner, bid: 5
      create :partner, bid: 15, position: :bottom
      create :partner, bid: 20, active: false
      create :partner, bid: 20, current_balance: 2000, budget: 1000
      PartnerCity.create(partner_id: partner.id, city: city)

      expect(Partner.filter(position, page.title, state.id, city.id)).to eq [partner]
    end
  end

  describe "#avg_price" do
    context "impressions_count is 0" do
      it "returns nil" do
        partner = create :partner
        expect(partner.avg_price).to eq nil
      end
      it "returns avg price" do
        partner = create :partner, current_balance: 10, impressions_count: 5
        expect(partner.avg_price).to eq 2
      end
    end
  end
end
