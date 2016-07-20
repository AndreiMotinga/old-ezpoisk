require "rails_helper"

describe StripeSubscriptionsController do
  before do
    @stripe_helper = StripeMock.create_test_helper
    sign_in(@user = create(:user))
    StripeMock.start
  end
  after do
    StripeMock.stop
  end

  describe "POST #create" do
    context "first time subscription" do
      it "creates stripe_subscription and cusomter on stripe server" do
        @stripe_helper.create_plan(id: "monthly")
        service = create :service, user: @user

        post :create, valid_attrs(service)

        expect(response).to redirect_to edit_dashboard_service_path(service.id)
        expect(flash[:notice]).to eq I18n.t(:stripe_subscription_created)

        expect(StripeSubscription.count).to eq 1

        sub = StripeSubscription.last
        expect(sub.active_until).to eq 1.month.from_now
        expect(sub.status).to eq "activated"
        expect(sub.service_id).to eq service.id
        expect(sub.customer_id).to_not eq nil
        expect(sub.sub_id).to_not eq nil

        expect(sub.remote_sub.status).to eq "active"
        expect(sub.remote_sub.plan.id).to eq "monthly"
        expect(sub.remote_sub.cancel_at_period_end).to eq false
      end
    end

    context "something went wrong" do
      it "doesn't create stripe_subscription, displays error alert" do
        StripeMock.prepare_card_error(:processing_error)
        @stripe_helper.create_plan(id: "monthly")
        service = create :service, user: @user

        post :create, invalid_attrs(service)

        expect(response).to redirect_to edit_dashboard_service_path(service.id)
        expect(flash[:alert]).to_not be nil

        expect(StripeSubscription.count).to eq 0
      end
    end
  end

  describe "DELETE #destroy" do
    context "successfully" do
      it "removes stipe_subscription" do
        @stripe_helper.create_plan(id: "monthly")
        customer = Stripe::Customer.create(
          source: @stripe_helper.generate_card_token,
          plan: "monthly"
        )
        service = create :service, user: @user
        sub = create(:stripe_subscription,
                     service: service,
                     customer_id: customer.id,
                     sub_id: customer.subscriptions.data[0].id,
                     active_until: 1.day.from_now)

        delete :destroy, id: sub.id

        expect(response).to redirect_to edit_dashboard_service_path(service)
        expect(flash[:notice]).to eq I18n.t(:stripe_subscription_cancelled)
        expect(StripeSubscription.count).to eq 1

        sub = StripeSubscription.last
        expect(sub.active_until).to eq 1.day.from_now
        expect(sub.status).to eq "cancelled"
        expect(sub.service_id).to eq service.id

        expect(sub.remote_sub.status).to eq "active"
        expect(sub.remote_sub.plan.id).to eq "monthly"
        expect(sub.remote_sub.cancel_at_period_end).to eq true
      end
    end

    context "user tries to remove someone else's sub" do
      it "throws 404" do
        sub = create :stripe_subscription

        expect { delete :destroy, id: sub.id }
          .to raise_error ActiveRecord::RecordNotFound
      end
    end

    context "something went wrong" do
      it "displays error message" do
        @stripe_helper.create_plan(id: "monthly")
        service = create :service, user: @user
        sub = create(:stripe_subscription,
                     service: service,
                     status: "activated",
                     active_until: 1.day.from_now)

        delete :destroy, id: sub.id

        expect(response).to redirect_to edit_dashboard_service_path(sub.service)
        expect(flash[:alert]).to_not be nil

        sub = StripeSubscription.last
        expect(sub.active_until).to eq 1.day.from_now
        expect(sub.status).to eq "activated"
      end
    end
  end

  describe "PUT #update" do
    context "success" do
      it "creates stripe_subscription and cusomter on stripe server" do
        @stripe_helper.create_plan(id: "monthly")
        service = create :service, user: @user
        customer = Stripe::Customer.create(
          source: @stripe_helper.generate_card_token,
          plan: "monthly"
        )
        local_sub = create(:stripe_subscription,
                           service: service,
                           customer_id: customer.id,
                           sub_id: customer.subscriptions.data[0].id,
                           active_until: 1.month.from_now)
        local_sub.cancel

        put :update, id: local_sub.id

        expect(response)
          .to redirect_to edit_dashboard_service_path(local_sub.service)
        expect(flash[:notice]).to eq I18n.t(:stripe_subscription_renewed)

        local_sub.reload
        expect(local_sub.status).to eq "activated"

        expect(local_sub.remote_sub.cancel_at_period_end).to eq false
        expect(local_sub.remote_sub.plan.id).to eq "monthly"
      end
    end

    context "with errors" do
      it "displays error" do
        @stripe_helper.create_plan(id: "monthly")
        service = create :service, user: @user
        local_sub = create(:stripe_subscription,
                           service: service,
                           status: "cancelled")

        put :update, id: local_sub.id

        expect(response)
          .to redirect_to edit_dashboard_service_path(local_sub.service)
        expect(flash[:alert]).to_not be nil

        local_sub.reload
        expect(local_sub.status).to eq "cancelled"
      end
    end
  end
end

def valid_attrs(service)
  {
    service_id: service.id,
    stripeToken: @stripe_helper.generate_card_token,
    plan: "monthly",
    stripeEmail: @user.email
  }
end

def invalid_attrs(service)
  {
    service_id: service.id,
    stripeToken: "",
    plan: "monthly",
    stripeEmail: @user.email
  }
end
