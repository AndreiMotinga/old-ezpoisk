require "rails_helper"

describe Dashboard::ServicesController do
  before { sign_in(@user = create(:user)) }

  describe "GET #new" do
    it "renders the new template and assigns @service" do
      get :new

      expect(response).to render_template(:new)
      expect(assigns(:service)).to be_a_new(Service)
    end
  end

  describe "GET #edit" do
    it "only shows record that belongs to user" do
      service = create :service
      create :service, user: @user

      expect { get :edit, id: service.id }
        .to raise_exception(ActiveRecord::RecordNotFound)
    end
  end

  describe "POST #create" do
    it "creates service" do
      attrs = attrs_with_state_and_city(:service)

      post :create, service: attrs
      service = assigns(:service)

      expect(response).to redirect_to(
        edit_dashboard_service_path(service)
      )
      expect(service.title).to eq attrs[:title]
      expect(service.user).to eq @user
    end
  end

  describe "PUT #update" do
    it "updates service" do
      service = create(:service, user: @user)
      attrs = attrs_with_state_and_city(:service)

      put :update, id: service.id, service: attrs
      updated_agency = assigns(:service)

      expect(response).to redirect_to(
        edit_dashboard_service_path(updated_agency)
      )
      expect(updated_agency.title).to eq attrs[:title]
      expect(updated_agency.street).to eq attrs[:street]
      expect(updated_agency.phone).to eq attrs[:phone]
      expect(updated_agency.email).to eq attrs[:email]
      expect(updated_agency.description).to eq attrs[:description]

      expect(updated_agency.city_id).to eq attrs[:city_id]
      expect(updated_agency.state_id).to eq attrs[:state_id]
      expect(updated_agency.user).to eq @user
    end
  end

  describe "DELETE #destroy" do
    before { StripeMock.start }
    after { StripeMock.stop }

    it "removes record and destroys customer" do
      cus = Stripe::Customer.create
      service = create(:service, user: @user)
      sub = service.create_stripe_subscription(stripe_id: cus.id)

      delete :destroy, id: service.id
      cus = Stripe::Customer.retrieve(cus.id)

      expect(response).to redirect_to(dashboard_path)
      expect(Service.count).to be 0
      expect(StripeSubscription.count).to be 0
      expect(cus.deleted).to be true
    end
  end

  describe "POST #payment" do
    let!(:stripe_helper) { StripeMock.create_test_helper }
    before { StripeMock.start }
    after { StripeMock.stop }
    let(:basic) { create :plan, :basic_monthly }

    it "processes payment successfully" do
      service = create(:service, active_until: nil, user: @user)
      plan = stripe_helper.create_plan(id: basic.title)
      card_token = StripeMock.generate_card_token(last4: "9191", exp_year: 2020)

      post :payment, id: service.id, plan: plan.id, stripeToken: card_token
      sub = StripeSubscription.last
      service.reload

      expect(response).to redirect_to edit_dashboard_service_path(service)
      expect(sub).to_not be nil
      expect(sub.stripe_id).to_not be nil
      expect(service.active_until).to_not be nil
    end

    it "catches error" do
      service = create(:service, active_until: nil, user: @user)
      plan = stripe_helper.create_plan(id: basic.title)
      card_token = "invalid_token"

      post :payment, id: service.id, plan: plan.id, stripeToken: card_token
      sub = StripeSubscription.last
      service.reload

      expect(response).to redirect_to edit_dashboard_service_path(service)
      expect(sub).to be nil
      expect(service.active_until).to be nil
    end
  end
end
