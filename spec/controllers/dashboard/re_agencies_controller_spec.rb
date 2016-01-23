require "rails_helper"

describe Dashboard::ReAgenciesController do
  before { sign_in(@user = create(:user)) }

  describe "GET #index" do
    it "renders the index template and return user's re_agencies" do
      2.times { create :re_agency, user: @user }
      create :re_agency # different user

      get :index
      agencies = assigns(:re_agencies)

      expect(response).to render_template(:index)
      expect(agencies.size).to eq 2
    end
  end

  describe "GET #new" do
    it "renders the new template and assigns @re_agency" do
      get :new

      expect(response).to render_template(:new)
      expect(assigns(:re_agency)).to be_a_new(ReAgency)
    end
  end

  describe "GET #edit" do
    it "only shows record that belongs to user" do
      re_agency = create :re_agency
      create :re_agency, user: @user

      get :edit, id: re_agency.id

      expect(response).to redirect_to(dashboard_path)
    end
  end

  describe "POST #create" do
    it "creates re_agency" do
      attrs = attrs_with_state_and_city(:re_agency)

      post :create, re_agency: attrs
      re_agency = assigns(:re_agency)

      expect(response).to redirect_to(
        edit_dashboard_re_agency_path(re_agency)
      )
      expect(re_agency.title).to eq attrs[:title]
      expect(re_agency.user).to eq @user
    end
  end

  describe "PUT #update" do
    it "updates re_agency" do
      re_agency = create(:re_agency, user: @user)
      attrs = attrs_with_state_and_city(:re_agency)

      put :update, id: re_agency.id,  re_agency: attrs
      updated_agency = assigns(:re_agency)

      expect(response).to redirect_to(
        edit_dashboard_re_agency_path(updated_agency)
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
      re_agency = create(:re_agency, user: @user)

      delete :destroy, id: re_agency.id

      expect(response).to redirect_to(dashboard_re_agencies_path)
      expect(ReAgency.count).to be 0
    end
  end
end
