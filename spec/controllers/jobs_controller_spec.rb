require "rails_helper"

describe JobsController do
  describe "GET #index" do
    it "renders the index template and assigns @jobs" do
      create_pair(:job)

      get :index

      expect(response).to render_template(:index)
      expect(assigns(:jobs).size).to eq 2
    end

    it "return only active models" do
      create_pair(:job, active: true)
      create :job, active: false

      get :index

      expect(assigns(:jobs).size).to eq 2
    end

    describe "#filter" do
      it "filters by state_id" do
        create_pair(:job, state_id: 1)
        create :job,  state_id: 32

        get :index, state_id: 32

        expect(assigns(:jobs).size).to eq 1
      end

      it "filters by city_id" do
        create_pair(:job, city_id: 18_030)
        create :job, city_id: 18_031
        create :job, city_id: 18_032

        get :index, city_id: [18_031, 18_032]

        expect(assigns(:jobs).size).to eq 2
      end

      it "filters by category" do
        create_pair(:job, category: JOB_CATEGORIES.first)
        create :job, category: JOB_CATEGORIES.second

        get :index, category: JOB_CATEGORIES.first

        expect(assigns(:jobs).size).to eq 2
      end
    end
  end

  describe "GET @show" do
    it "renders the show template and assigns @job if its active" do
      job = create(:job)

      get :show, id: job.id

      expect(response).to render_template(:show)
      expect(assigns(:job)).to eq job
    end

    it "redirects to 404 if it's inactive" do
      job = create(:job, active: false)

      get :show, id: job.id

      expect(response).to redirect_to jobs_path
      expect(flash[:alert]).to eq I18n.t(:post_not_found)
    end
  end
end
