require "rails_helper"

describe StripeSubscription do
  it { should belong_to(:service) }
  it { should validate_presence_of(:service_id) }

  describe "#cancel" do
    let(:stripe_helper) { StripeMock.create_test_helper }
    before { StripeMock.start }
    after { StripeMock.stop }

    it "cancels subscription at period end" do
      stripe_helper.create_plan(id: "monthly")
      customer = Stripe::Customer.create(
        source: stripe_helper.generate_card_token,
        plan: "monthly"
      )
      sub = create(:stripe_subscription,
                   customer_id: customer.id,
                   sub_id: customer.subscriptions.data[0].id)

      sub.cancel

      sub.reload
      expect(sub.status).to eq "cancelled"

      customer = Stripe::Customer.retrieve(customer.id)
      expect(customer.subscriptions.data[0].cancel_at_period_end).to eq true
    end
  end

  describe "#cancelled?" do
    it "" do
      sub = create(:stripe_subscription,
                   active_until: 1.month.from_now,
                   status: "cancelled")
      expect(sub.cancelled?).to be true
    end
  end

  describe "#active?" do
    it "" do
      sub = create(:stripe_subscription, active_until: 1.month.from_now)

      expect(sub.active?).to be true
    end
  end

  describe "#expired?" do
    it "returns true if sub was cancelled and has expired" do
      active = create(:stripe_subscription, active_until: 1.day.from_now)
      expired = create(:stripe_subscription, active_until: 1.day.ago)

      expect(active.expired?).to be false
      expect(expired.expired?).to be true
    end
  end
end
