require "rails_helper"

describe Partner do
  it { should validate_presence_of :title }
  it { should validate_presence_of :image }
  it { should belong_to(:user) }

  it "should validate position for side" do
    partner = build :partner, :side, page: "Домашняя"
    expect(partner.valid?).to be false
    expect(partner.errors[:position]).to be
  end
  it "should validate position for side for bottom" do
    partner = build :partner, :bottom, page: "Домашняя"
    expect(partner.valid?).to be false
    expect(partner.errors[:position]).to be
  end

  describe ".active" do
    it "returns only active partners" do
      create(:partner, :past)
      create(:partner, :future)
      p = create(:partner, :current)

      expect(Partner.active).to eq [p]
    end
  end

  describe ".by_position" do
    it "return partners of certain position" do
      top = create :partner
      bottom = create :partner, :bottom
      side = create :partner, :side

      expect(Partner.by_position(top.position)).to eq [top]
      expect(Partner.by_position(bottom.position)).to eq [bottom]
      expect(Partner.by_position(side.position)).to eq [side]
    end
  end

  describe ".current" do
    it "returns correct partner" do
      create(:partner, :past)
      create(:partner, :future)
      create(:partner, :bottom, :current)
      partner = create(:partner, :current)

      p = Partner.current(partner.page, partner.position)

      expect(p).to eq partner
    end
  end

  describe "#available_start_date" do
    context "there are no similar partners" do
      it "returns today" do
        partner = create(:partner, start_date: nil, active_until: nil)
        expect(partner.available_start_date).to eq Date.today
      end
    end

    context "existing active partner" do
      it "returns end date of currently active similar partner" do
        create(:partner,
               start_date: Date.today,
               active_until: Date.today + 1.week)
        partner = create(:partner)

        expect(partner.available_start_date).to eq Date.today + 1.week
      end
    end

    context "active partner and next one waiting" do
      it "returns end date of latest active similar partner" do
        create(:partner, :current)
        future = create(:partner, :future)
        partner = create(:partner)

        expect(partner.available_start_date).to eq future.active_until
      end
    end
  end

  describe "#activate" do
    context "no current partners" do
      it "it sets start and active_until dates" do
        partner = create :partner
        partner.activate("2", 20)
        expect(partner.start_date).to eq Date.today
        expect(partner.active_until).to eq Date.today + 2.weeks
      end
    end

    context "with existing current_partner" do
      it "it sets start and active_until dates when where is active partner" do
        create(:partner, :current)
        next_partner = create(:partner)

        next_partner.activate("1", 1)

        expect(next_partner.start_date).to eq 1.week.from_now.to_date
        expect(next_partner.active_until).to eq 2.weeks.from_now.to_date
      end
    end

    context "with current partner and one in the future" do
      it "it sets start and active_until dates" do
        create(:partner, :current)
        future = create(:partner, :future)
        partner = create(:partner)

        partner.activate("1", 1)

        expect(partner.start_date).to eq future.active_until
        expect(partner.active_until).to eq(future.active_until + 1.week)
      end
    end
  end
end
