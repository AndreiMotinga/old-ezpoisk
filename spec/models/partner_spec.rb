require "rails_helper"

describe Partner do
  it { should validate_presence_of :title }
  it { should validate_presence_of :image }
  # it { should validate_presence_of :state_id }
  it { should belong_to(:user) }
  it { should belong_to(:state) }

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
      state = create :state
      create(:partner, :past, state: state)
      create(:partner, :future, state: state)
      p = create(:partner, :current, state: state)

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

  describe ".by_state" do
    it "returns partners by state" do
      state = create :state
      partner = create :partner, state: state
      create :partner, state: create(:state)

      expect(Partner.by_state(state.id).size).to eq 1
      expect(Partner.by_state(state.id).first).to eq partner
    end
  end

  describe ".current" do
    # uncomment when use states again
    # it "return correct partner" do
    #   state = create(:state)
    #   create(:partner, :past, state: state)
    #   create(:partner, :future, state: state)
    #   create(:partner, :bottom, :current, state: state)
    #   partner = create(:partner, :current, state: state)
    #
    #   p = Partner.current(state.id, partner.page, partner.position)
    #
    #   expect(p).to eq partner
    # end

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
        state = create :state
        create(:partner,
               state: state,
               start_date: Date.today,
               active_until: Date.today + 1.week)
        partner = create(:partner, state: state)

        expect(partner.available_start_date).to eq Date.today + 1.week
      end
    end

    context "active partner and next one waiting" do
      it "returns end date of latest active similar partner" do
        state = create :state
        create(:partner, :current, state: state)
        future = create(:partner, :future, state: state)
        partner = create(:partner, state: state)

        expect(partner.available_start_date).to eq future.active_until
      end
    end
  end

  describe "#amount_to_pay" do
    context "user is admin" do
      it "return 100" do
        admin = create :user, :admin
        partner = create :partner, user: admin

        expect(partner.amount_to_pay(1, admin)).to eq 100
        expect(partner.amount_to_pay(2, admin)).to eq 100
        expect(partner.amount_to_pay(4, admin)).to eq 100
      end
    end

    context "for 1 week" do
      it "returns 14000" do
        partner = create :partner

        expect(partner.amount_to_pay(1)).to eq (14 * 1 * 7 * 100)
        expect(partner.amount_to_pay(2)).to eq (11 * 2 * 7 * 100)
        expect(partner.amount_to_pay(4)).to eq (9 * 4 * 7 * 100)
      end
    end
  end

  describe "#activate" do
    context "no current partners" do
      it "it sets start and active_until dates" do
        partner = create :partner
        partner.activate("2")
        expect(partner.start_date).to eq Date.today
        expect(partner.active_until).to eq Date.today + 2.weeks
      end
    end

    context "with existing current_partner" do
      it "it sets start and active_until dates when where is active partner" do
        state = create(:state)
        create(:partner, :current, state: state)
        next_partner = create(:partner, state: state)

        next_partner.activate("1")

        expect(next_partner.start_date).to eq 1.week.from_now.to_date
        expect(next_partner.active_until).to eq 2.weeks.from_now.to_date
      end
    end

    context "with current partner and one in the future" do
      it "it sets start and active_until dates" do
        state = create(:state)
        create(:partner, :current, state: state)
        future = create(:partner, :future, state: state)
        partner = create(:partner, state: state)

        partner.activate("1")

        expect(partner.start_date).to eq future.active_until
        expect(partner.active_until).to eq(future.active_until + 1.week)
      end
    end
  end
end
