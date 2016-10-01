require "rails_helper"

describe ServicesController do
  describe "GET #index" do
    it "renders the index template and assigns @services" do
      2.times { create :service }

      get :index

      expect(response).to render_template(:index)
      services = assigns(:services)
      expect(services.size).to eq 2
      expect(IncreaseImpressionsJob.jobs.size).to eq 1
      job = IncreaseImpressionsJob.jobs.first
      expect(job["args"].first).to eq services.pluck :id
      expect(job["args"].second).to eq "Service"
    end

    describe "#filter" do
      xit "returns records according to priority" do
        create :service, :job_agency, title: "third", priority: 0
        create :service, :job_agency, title: "second", priority: 1
        create :service, :job_agency, title: "first", priority: 2

        get :index, params: { category: "Работа" }
        result = assigns(:services).pluck(:title)

        expect(result).to eq %w(first second third)
      end
    end
  end

  describe "GET @show" do
    it "renders the show template and assigns @service" do
      service = create(:service)

      get :show, params: { id: service.id }
      record = assigns :service

      expect(response).to render_template(:show)
      expect(record).to be_a Service
    end
  end
end
