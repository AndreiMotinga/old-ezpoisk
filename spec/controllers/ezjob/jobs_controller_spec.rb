require "rails_helper"

describe Ezjob::JobsController do
  describe "GET #index" do
    it "renders the index template and assigns @jobs" do
      2.times { create :job, :active }

      get :index

      expect(response).to render_template(:index)
      expect(assigns(:jobs).size).to eq 2
    end

    it "return only active models" do
      2.times { create :job, :active }
      create :job, active: false

      get :index

      expect(assigns(:jobs).size).to eq 2
    end

    describe "#filter" do
      it "filters by state_id" do
        new_york = create(:state, name: "New York")
        alabama = create(:state, name: "Alabama")
        2.times { create :job, :active, state_id: alabama.id }
        create :job, :active,  state_id: new_york.id

        get :index, state_id: new_york.id

        expect(assigns(:jobs).size).to eq 1
      end

      it "filters by city_id" do
        brooklyn = create(:city, name: "Brooklyn")
        bronx = create(:city, name: "Bronx")
        queens  = create(:city, name: "Queens")
        2.times { create :job, :active, city_id: queens.id }
        create :job, :active,  city_id: brooklyn.id
        create :job, :active, city_id: bronx.id

        get :index, city_id: [brooklyn.id, bronx.id]

        expect(assigns(:jobs).size).to eq 2
      end

      it "filters by category" do
        2.times { create :job, :active, category: JOB_CATEGORIES.first }
        create :job, :active, category: JOB_CATEGORIES.second

        get :index, category: JOB_CATEGORIES.first

        expect(assigns(:jobs).size).to eq 2
      end
    end
  end

  describe "GET @show" do
    it "renders the show template and assigns @job if its active" do
      job = create(:job, :active)

      get :show, id: job.id

      expect(response).to render_template(:show)
      expect(assigns(:job)).to eq job
      expect(flash[:alert]).to be nil
    end

    it "redirects to 404 if it's inactive" do
      job = create(:job, active: false)

      get :show, id: job.id

      expect(response).to redirect_to ezjob_jobs_path
      expect(flash[:alert]).to eq I18n.t(:post_not_found)
    end
  end
end
