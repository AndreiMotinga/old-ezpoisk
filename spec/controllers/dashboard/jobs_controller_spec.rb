require "rails_helper"

describe Dashboard::JobsController do
  before { sign_in(@user = create(:user)) }

  describe "GET #index" do
    it "renders the index template and return user's jobs" do
      2.times { create :job, user: @user }
      create :job # different user

      get :index
      jobs = assigns(:jobs)

      expect(response).to render_template(:index)
      expect(jobs.size).to eq 2
    end
  end

  describe "GET #new" do
    it "renders the new template and assigns @job" do
      get :new

      expect(response).to render_template(:new)
      expect(assigns(:job)).to be_a_new(Job)
    end
  end

  describe "GET #edit" do
    it "only shows record that belongs to user" do
      job = create :job
      create :job, user: @user

      get :edit, id: job.id

      expect(response).to redirect_to(dashboard_path)
    end
  end

  describe "POST #create" do
    it "creates job" do
      attrs = attrs_with_state_and_city(:job)

      post :create, job: attrs
      job = assigns(:job)

      expect(response).to redirect_to(
        edit_dashboard_job_path(job)
      )
      expect(job.title).to eq attrs[:title]
      expect(job.user).to eq @user
    end
  end

  describe "PUT #update" do
    it "updates job" do
      job = create(:job, user: @user)
      attrs = attrs_with_state_and_city(:job)

      put :update, id: job.id,  job: attrs
      updated_agency = assigns(:job)

      expect(response).to redirect_to(
        edit_dashboard_job_path(updated_agency)
      )
      expect(updated_agency.title).to eq attrs[:title]
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
      job = create(:job, user: @user)

      delete :destroy, id: job.id

      expect(response).to redirect_to(dashboard_jobs_path)
      expect(Job.count).to be 0
    end
  end
end
