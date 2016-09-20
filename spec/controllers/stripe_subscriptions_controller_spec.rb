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
        @stripe_helper.create_plan(id: "monthly_base")
        service = create :service, user: @user

        post :create, params: valid_attrs(service)

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
        expect(sub.remote_sub.plan.id).to eq "monthly_base"
        expect(sub.remote_sub.cancel_at_period_end).to eq false

        service.reload
        expect(service.priority).to eq 1
      end
    end

    context "something went wrong" do
      it "doesn't create stripe_subscription, displays error alert" do
        StripeMock.prepare_card_error(:processing_error)
        @stripe_helper.create_plan(id: "monthly_base")
        service = create :service, user: @user

        post :create, params: invalid_attrs(service)

        expect(response).to redirect_to edit_dashboard_service_path(service.id)
        expect(flash[:alert]).to_not be nil

        expect(StripeSubscription.count).to eq 0
      end
    end
  end
end

def valid_attrs(service)
  {
    service_id: service.id,
    stripeToken: @stripe_helper.generate_card_token,
    plan: "monthly_base",
    stripeEmail: @user.email
  }
end

def invalid_attrs(service)
  {
    service_id: service.id,
    stripeToken: "",
    plan: "monthly_base",
    stripeEmail: @user.email
  }
end
