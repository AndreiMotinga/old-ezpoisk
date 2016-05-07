require "rails_helper"

describe PartnerChargeCalculator do
  describe "#amount_to_pay" do
    context "user is admin" do
      it "returns 100" do
        admin = create :user, :admin
        one_week = PartnerChargeCalculator.new(1, admin).amount_to_pay
        two_weeks = PartnerChargeCalculator.new(2, admin).amount_to_pay
        four_weeks = PartnerChargeCalculator.new(4, admin).amount_to_pay

        expect(one_week).to eq 100
        expect(two_weeks).to eq 100
        expect(four_weeks).to eq 100
      end
    end

    context "for 1 week" do
      it "returns 14000" do
        one_week = PartnerChargeCalculator.new(1).amount_to_pay
        two_weeks = PartnerChargeCalculator.new(2).amount_to_pay
        four_weeks = PartnerChargeCalculator.new(4).amount_to_pay

        expect(one_week).to eq (14 * 1 * 7 * 100)
        expect(two_weeks).to eq (11 * 2 * 7 * 100)
        expect(four_weeks).to eq (9 * 4 * 7 * 100)
      end
    end
  end
end
