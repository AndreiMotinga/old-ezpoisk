require "rails_helper"

describe JobsController do
  describe "GET #index" do
    it "renders the index template and assigns @jobs" do
      create_pair(:job)

      get :index

      jobs = assigns(:jobs)
      expect(response).to render_template(:index)
      expect(jobs.size).to eq 2
      expect(IncreaseImpressionsJob.jobs.size).to eq 1
      job = IncreaseImpressionsJob.jobs.first
      expect(job["args"].first).to eq jobs.pluck :id
      expect(job["args"].second).to eq "Job"
    end

    it "return only active models" do
      create_pair(:job, active: true)
      create :job, active: false

      get :index

      expect(assigns(:jobs).size).to eq 2
    end
  end

  describe "GET @show" do
    it "renders the show template and assigns @job if its active" do
      job = create(:job)

      get :show, params: { id: job.id }

      expect(response).to render_template(:show)
      expect(assigns(:job)).to eq job
    end

    it "redirects to 404 if it's inactive" do
      job = create(:job, active: false)

      get :show, params: { id: job.id }

      expect(response).to redirect_to jobs_path
      expect(flash[:alert]).to eq I18n.t(:post_not_found)
    end
  end
end
