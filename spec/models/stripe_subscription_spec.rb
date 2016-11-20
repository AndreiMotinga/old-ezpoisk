require "rails_helper"

xdescribe StripeSubscription do
  it { should belong_to(:service) }
  it { should validate_presence_of(:service_id) }

  describe "WEBHOOKS" do
    before do
      @stripe_helper = StripeMock.create_test_helper
      StripeMock.start
    end
    after do
      StripeMock.stop
    end

    describe "after_invoice_payment_succeeded" do
      it "updates subscription's active_until" do
        @stripe_helper.create_plan(id: "monthly")
        customer = Stripe::Customer.create(
          source: @stripe_helper.generate_card_token,
          plan: "monthly"
        )
        create(:stripe_subscription,
               customer_id: customer.id,
               sub_id: customer.subscriptions.data[0].id,
               active_until: 1.day.from_now)

        event = StripeMock.mock_webhook_event(
          "invoice.payment_succeeded",
          customer: customer.id
        )
        StripeSubscription
          .after_invoice_payment_succeeded!
          .first
          .call(event.data.object, "_foo")

        sub = StripeSubscription.last
        expect(sub.active_until).to eq 1.month.from_now
      end
    end

    describe "after_invoice_payment_failed!" do
      it "destroys customer and subscription" do
        @stripe_helper.create_plan(id: "monthly")
        customer = Stripe::Customer.create(
          source: @stripe_helper.generate_card_token,
          plan: "monthly"
        )
        create(:stripe_subscription,
               customer_id: customer.id,
               sub_id: customer.subscriptions.data[0].id,
               active_until: 1.day.from_now)

        event = StripeMock.mock_webhook_event(
          "invoice.payment_succeeded",
          customer: customer.id
        )
        StripeSubscription
          .after_invoice_payment_failed!
          .first
          .call(event.data.object, "_foo")

        remote_cus = Stripe::Customer.retrieve(customer.id)
        expect(remote_cus.deleted).to eq true

        expect(StripeSubscription.count).to eq 0
      end
    end
  end
end
