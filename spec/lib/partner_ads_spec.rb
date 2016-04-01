require "rails_helper"

describe PartnerAds do
  describe "" do
    it "returns nil when there are no partners" do
      session = {state_id: 1, city_id: 1}
      top = PartnerAds.new("Домашняя", session).top
      expect(top).to eq nil
    end

    describe "PAGES" do
      it "returns partner for page" do
        state = create :state
        city = create :city
        session = { state_id: state.id, city_id: city.id }
        page = create :page
        partner = create :partner, state: state, page_list: [page.title]
        PartnerCity.create(partner_id: partner.id, city: city)

        top = PartnerAds.new(page.title, session).top
        expect(top).to eq partner
      end
    end

    describe "POSITION" do
      it "returns partner for correct position" do
        state = create :state
        city = create :city
        session = { state_id: state.id, city_id: city.id }
        bottom_partner = create :partner, position: :bottom, state: state
        top_partner = create :partner, position: :top, state: state
        PartnerCity.create(partner_id: bottom_partner.id, city: city)
        PartnerCity.create(partner_id: top_partner.id, city: city)

        partner_ads = PartnerAds.new("Домашняя", session)

        expect(partner_ads.top).to eq top_partner
        expect(partner_ads.bottom).to eq bottom_partner
      end
    end

    describe "incease impressions_count" do
      it "increases after picking which partner to show" do
        state = create :state
        city = create :city
        session = { state_id: state.id, city_id: city.id }
        bottom_partner = create :partner, position: :bottom, state: state
        top_partner = create :partner, position: :top, state: state
        PartnerCity.create(partner_id: bottom_partner.id, city: city)
        PartnerCity.create(partner_id: top_partner.id, city: city)

        partner_ads = PartnerAds.new("Домашняя", session)
        top = partner_ads.top
        bottom = partner_ads.bottom

        expect(top.impressions_count).to eq 1
        expect(bottom.impressions_count).to eq 1
      end
    end

    xcontext "CHARGE" do
      it "charges only when displayed" do
        state = create :state
        page = create :page
        top_partner = create :partner, position: :top, state: state
        # PartnerPage.create(page: page, partner: top_partner)

        PartnerAds.new("Домашняя", state.id)

        top_partner.reload

        expect(top_partner.current_balance).to eq 1
      end

      it "charges 1 cent when there's no competition" do
        page = create :page
        top_partner = create :partner, bid: 5
        # PartnerPage.create(page: page, partner: top_partner)

        PartnerAds.new("Домашняя", 1).top
        top_partner.reload

        expect(top_partner.current_balance).to eq 1
      end

      it "charges next competitor's price + 1 cent" do
        page = create :page
        top_partner = create :partner, bid: 5
        next_partner = create :partner, bid: 1
        # PartnerPage.create(page: page, partner: top_partner)
        # PartnerPage.create(page: page, partner: next_partner)

        PartnerAds.new("Домашняя", 1).top
        top_partner.reload

        expect(top_partner.current_balance).to eq 2
      end

      it "charges own price when next competitor is the same" do
        page = create :page
        top_partner = create :partner, bid: 5
        next_partner = create :partner, bid: 5
        # PartnerPage.create(page: page, partner: top_partner)
        # PartnerPage.create(page: page, partner: next_partner)

        PartnerAds.new("Домашняя", 1).top
        top_partner.reload

        expect(top_partner.current_balance).to eq 5
      end
    end
  end
end
