require "rails_helper"

describe Partner do
  it { should validate_presence_of :title }
  it { should belong_to(:user) }
  it { should have_many(:partner_pages) }
  it { should have_many(:pages).through(:partner_pages)}

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
      the_one = create :partner, position: :top
      create :partner, position: :bottom

      expect(Partner.by_position(:top)).to eq [the_one]
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

  describe ".by_page" do
    it "sorts partners by bids highest first" do
      partner = create :partner
      page = create :page

      wrong = create :partner
      wrong_page = create :page, :ezrealty
      PartnerPage.create(page: page, partner: partner)
      PartnerPage.create(page: wrong_page, partner: wrong)

      expect(Partner.by_page(page.title)).to eq [partner]
    end
  end

  describe ".filter" do
    it "return correct partner" do
      partner = create :partner, bid: 10, position: :top
      create :partner, bid: 5
      create :partner, bid: 15, position: :bottom
      create :partner, bid: 20, active: false
      create :partner, bid: 20, current_balance: 2000, budget: 1000
      page = create :page, title: "Домашняя"
      PartnerPage.create(page: page, partner: partner)

      expect(Partner.filter(:top, "Домашняя")).to eq [partner]
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
