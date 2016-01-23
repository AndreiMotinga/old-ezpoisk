require "rails_helper"

describe Dashboard::ServicesController do
  before { sign_in(@user = create(:user)) }

  describe "GET #index" do
    it "renders the index template and return user's services" do
      2.times { create :service, user: @user }
      create :service # different user

      get :index
      services = assigns(:services)

      expect(response).to render_template(:index)
      expect(services.size).to eq 2
    end
  end

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

      get :edit, id: service.id

      expect(response).to redirect_to(dashboard_path)
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
      expect(updated_agency.active).to eq attrs[:active]

      expect(updated_agency.city_id).to eq attrs[:city_id]
      expect(updated_agency.state_id).to eq attrs[:state_id]
      expect(updated_agency.user).to eq @user
    end
  end

  describe "DELETE #destroy" do
    it "removes record" do
      service = create(:service, user: @user)

      delete :destroy, id: service.id

      expect(response).to redirect_to(dashboard_services_path)
      expect(Service.count).to be 0
    end
  end
end
