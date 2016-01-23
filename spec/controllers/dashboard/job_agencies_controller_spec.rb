require "rails_helper"

describe Dashboard::JobAgenciesController do
  before { sign_in(@user = create(:user)) }

  describe "GET #index" do
    it "renders the index template and return user's job_agencies" do
      2.times { create :job_agency, user: @user }
      create :job_agency # different user

      get :index
      agencies = assigns(:job_agencies)

      expect(response).to render_template(:index)
      expect(agencies.size).to eq 2
    end
  end

  describe "GET #new" do
    it "renders the new template and assigns @job_agency" do
      get :new

      expect(response).to render_template(:new)
      expect(assigns(:job_agency)).to be_a_new(JobAgency)
    end
  end

  describe "GET #edit" do
    it "only shows record that belongs to user" do
      job_agency = create :job_agency
      create :job_agency, user: @user

      get :edit, id: job_agency.id

      expect(response).to redirect_to(dashboard_path)
    end
  end

  describe "POST #create" do
    it "creates job_agency" do
      attrs = attrs_with_state_and_city(:re_agency)

      post :create, job_agency: attrs
      job_agency = assigns(:job_agency)

      expect(response).to redirect_to(
        edit_dashboard_job_agency_path(job_agency)
      )
      expect(job_agency.title).to eq attrs[:title]
      expect(job_agency.user).to eq @user
    end
  end

  describe "PUT #update" do
    it "updates job_agency" do
      job_agency = create(:job_agency, user: @user)
      attrs = attrs_with_state_and_city(:re_agency)

      put :update, id: job_agency.id, job_agency: attrs
      updated_agency = assigns(:job_agency)

      expect(response).to redirect_to(
        edit_dashboard_job_agency_path(updated_agency)
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
      job_agency = create(:job_agency, user: @user)

      delete :destroy, id: job_agency.id

      expect(response).to redirect_to(dashboard_job_agencies_path)
      expect(JobAgency.count).to be 0
    end
  end
end
