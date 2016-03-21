require "rails_helper"

describe PartnerAds do
  describe "" do
    it "returns nil when there are no partners" do
      top = PartnerAds.new("Домашняя", 1).top
      expect(top).to eq nil
    end

    describe "PAGES" do
      it "returns partner for page Домашняя" do
        page = create :page, title: "Домашняя"
        wrong_page = create :page, title: "Недвижимость"
        partner = create :partner
        wrong_partner = create :partner
        PartnerPage.create(page: wrong_page, partner: wrong_partner)
        PartnerPage.create(page: page, partner: partner)

        top = PartnerAds.new("Домашняя", 1).top
        expect(top).to eq partner
      end
    end

    describe "POSITION" do
      it "returns partner for correct position" do
        page = create :page
        bottom_partner = create :partner, position: :bottom
        top_partner = create :partner, position: :top
        PartnerPage.create(page: page, partner: bottom_partner)
        PartnerPage.create(page: page, partner: top_partner)

        partner_ads = PartnerAds.new("Домашняя", 1, nil, 1)

        expect(partner_ads.top).to eq top_partner
        expect(partner_ads.bottom).to eq bottom_partner
      end
    end

    context "CHARGE" do
      it "charges only when displayed" do
        page = create :page
        top_partner = create :partner, position: :top
        bottom_partner = create :partner, position: :bottom
        PartnerPage.create(page: page, partner: top_partner)
        PartnerPage.create(page: page, partner: bottom_partner)

        PartnerAds.new("Домашняя", 1).top

        top_partner.reload
        bottom_partner.reload

        expect(top_partner.current_balance).to eq 1
        expect(bottom_partner.current_balance).to eq 0
      end

      it "charges 1 cent when there's no competition" do
        page = create :page
        top_partner = create :partner, bid: 5
        PartnerPage.create(page: page, partner: top_partner)

        PartnerAds.new("Домашняя", 1).top
        top_partner.reload

        expect(top_partner.current_balance).to eq 1
      end

      it "charges next competitor's price + 1 cent" do
        page = create :page
        top_partner = create :partner, bid: 5
        next_partner = create :partner, bid: 1
        PartnerPage.create(page: page, partner: top_partner)
        PartnerPage.create(page: page, partner: next_partner)

        PartnerAds.new("Домашняя", 1).top
        top_partner.reload

        expect(top_partner.current_balance).to eq 2
      end

      it "charges own price when next competitor is the same" do
        page = create :page
        top_partner = create :partner, bid: 5
        next_partner = create :partner, bid: 5
        PartnerPage.create(page: page, partner: top_partner)
        PartnerPage.create(page: page, partner: next_partner)

        PartnerAds.new("Домашняя", 1).top
        top_partner.reload

        expect(top_partner.current_balance).to eq 5
      end
    end
  end
end
