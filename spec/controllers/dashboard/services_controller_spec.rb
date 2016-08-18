require "rails_helper"

describe Dashboard::ServicesController do
  describe "GET #new" do
    it "renders the new template and assigns @service" do
     sign_in(@user = create(:user))

      get :new

      expect(response).to render_template(:new)
      expect(assigns(:service)).to be_a_new(Service)
    end
  end

  describe "GET #edit" do
    it "only shows record that belongs to user" do
      sign_in(@user = create(:user))
      service = create :service
      create :service, user: @user

      expect { get :edit, params: { id: service.id } }
        .to raise_exception(ActiveRecord::RecordNotFound)
    end

    context "with token" do
      it "renders page" do
        service = create :service

        get :edit, params: { id: service.id, token: service.token }

        expect(response).to render_template(:edit)
        expect(assigns(:service)).to eq service
      end
    end
  end

  describe "POST #create" do
    it "creates service" do
      sign_in(@user = create(:user))
      attrs = attributes_for(:service)

      post :create, params: { service: attrs }
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
      sign_in(@user = create(:user))
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
      expect(updated_agency.description).to eq attrs[:description]

      expect(updated_agency.city_id).to eq attrs[:city_id]
      expect(updated_agency.state_id).to eq attrs[:state_id]
      expect(updated_agency.user).to eq @user
    end

    context "with token" do
      it "updates the record" do
        service = create :service
        attrs = attributes_for(:service, title: service.title)

        put :update, params: {
          id: service.id, service: attrs, token: service.token
        }

        expect(response).to redirect_to(
          edit_dashboard_service_path(service, token: service.token)
        )
        service.reload

        expect(service.street).to eq attrs[:street]
        expect(flash[:notice]).to eq I18n.t(:post_saved)
      end
    end
  end

  describe "DELETE #destroy" do
    it "removes record" do
      sign_in(@user = create(:user))
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
        sign_in(@user = create(:user))
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

      context "with token" do
        it "removes record and entry" do
          service = create :service

          delete :destroy, params: { id: service.id, token: service.token }

          expect(response).to redirect_to(root_path)
          expect(flash[:notice]).to eq I18n.t(:post_removed)
        end
      end
    end
  end
end

def remote_sub(sub)
  customer = Stripe::Customer.retrieve(sub.customer_id)
  customer.subscriptions.retrieve(sub.sub_id)
end
