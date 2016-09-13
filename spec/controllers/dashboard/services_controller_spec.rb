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

      expect { get :edit, params: { id: service.id } }
        .to raise_exception(ActiveRecord::RecordNotFound)
    end
  end

  describe "POST #create" do
    it "creates service" do
      attrs = attributes_for(:service)

      post :create, params: { service: attrs }
      service = assigns(:service)

      expect(response).to redirect_to(
        edit_dashboard_service_path(service)
      )
      expect(flash[:notice]).to eq I18n.t(:post_created)
      expect(service.title).to eq attrs[:title]
      expect(service.user).to eq @user
      expect(service.active).to be true

      expect(GeocodeJob.jobs.size).to eq 1
      expect(FacebookNotifierJob.jobs.size).to eq 1
      expect(VkNotifierJob.jobs.size).to eq 1
    end
  end

  describe "PUT #update" do
    it "updates service" do
      service = create(:service, user: @user)
      attrs = attributes_for(:service)

      put :update, params: { id: service.id, service: attrs }
      updated_agency = assigns(:service)

      expect(response).to redirect_to(
        edit_dashboard_service_path(updated_agency)
      )
      expect(updated_agency.title).to eq attrs[:title]
      expect(updated_agency.street).to eq attrs[:street]
      expect(updated_agency.phone).to eq attrs[:phone]
      expect(updated_agency.email).to eq attrs[:email]
      expect(updated_agency.text).to eq attrs[:text]

      expect(updated_agency.city_id).to eq attrs[:city_id]
      expect(updated_agency.state_id).to eq attrs[:state_id]
      expect(updated_agency.user).to eq @user
    end
  end

  describe "DELETE #destroy" do
    it "removes record" do
      service = create(:service, user: @user)

      delete :destroy, params: { id: service.id }

      expect(response).to redirect_to(dashboard_path)
      expect(flash[:notice]).to eq I18n.t(:post_removed)
      expect(Service.count).to be 0
      expect(Entry.count).to be 0
    end

    context "removes subscriptions" do
      before do
        @stripe_helper = StripeMock.create_test_helper
        StripeMock.start
      end
      after { StripeMock.stop }

      it "cancels stripe_subscription" do
        @stripe_helper.create_plan(id: "monthly")
        service = create :service, user: @user
        customer = Stripe::Customer.create(
          source: @stripe_helper.generate_card_token,
          plan: "monthly"
        )
        sub = create(:stripe_subscription,
                     service: service,
                     customer_id: customer.id,
                     sub_id: customer.subscriptions.data[0].id,
                     active_until: 1.month.from_now,
                     status: "activated")

        delete :destroy, params: { id: service.id }

        expect(response).to redirect_to(dashboard_path)
        expect(flash[:notice]).to eq I18n.t(:post_removed)
        expect(Service.count).to be 0

        expect(remote_sub(sub).cancel_at_period_end).to eq true
      end
    end
  end
end

def remote_sub(sub)
  customer = Stripe::Customer.retrieve(sub.customer_id)
  customer.subscriptions.retrieve(sub.sub_id)
end
