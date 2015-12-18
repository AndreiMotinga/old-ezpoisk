require "rails_helper"

describe Dashboard::ReAgenciesController do
  describe "GET #index" do
    it "only returns current_users re_agencies" do
      me = create :user
      sign_in me
      2.times { create :re_agency, user: me }
      create :re_agency # not my agency

      get :index
      agencies = assigns(:re_agencies)

      expect(response).to be_success
      expect(agencies.size).to eq 2
    end
  end

  describe "POST #create" do
    it "creates re_agency" do
      # TODO :extrct method
      me = create :user
      sign_in me
      attrs = attributes_for(:re_agency)
      state = create :state
      city = create :city
      attrs[:state_id] = state.id
      attrs[:city_id] = city.id
      attrs[:user_id] = me.id

      post :create, re_agency: attrs
      agency = assigns(:re_agency)

      expect(response).to redirect_to(
        dashboard_re_agency_path(
          agency,
          notice: "Re agency was successfully created."
        )
      )
      expect(agency.title).to eq attrs[:title]
      expect(agency.user).to eq me
    end
  end

  describe "PUT #update" do
    it "updates re_agency" do
      me = create :user
      sign_in me
      re_agency = create(:re_agency)
      attrs = attributes_for(:re_agency)
      state = create :state
      city = create :city
      attrs[:state_id] = state.id
      attrs[:city_id] = city.id
      attrs[:user_id] = me.id

      put :update, id: re_agency.id,  re_agency: attrs
      updated_agency = assigns(:re_agency)

      expect(response).to redirect_to(
        dashboard_re_agency_path(updated_agency)
      )
      expect(updated_agency.title).to eq attrs[:title]
      expect(updated_agency.street).to eq attrs[:street]
      expect(updated_agency.phone).to eq attrs[:phone]
      expect(updated_agency.email).to eq attrs[:email]
      expect(updated_agency.description).to eq attrs[:description]
      expect(updated_agency.active).to eq attrs[:active]

      expect(updated_agency.city_id).to eq attrs[:city_id]
      expect(updated_agency.state_id).to eq attrs[:state_id]
      expect(updated_agency.user).to eq me
    end
  end

  describe "DELETE #destroy" do
    it "removes record" do
      re_agency = create(:re_agency)

      delete :destroy, id: re_agency.id

      expect(response).to redirect_to(dashboard_re_agencies_path)
      expect(ReAgency.count).to be 0
    end
  end
end
