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
      it "filters by state_id" do
        2.times { create :service, state_id: 1 }
        create :service, state_id: 32

        get :index, params: { state_id: 32 }

        expect(assigns(:services).size).to eq 1
      end

      it "filters by city_id" do
        2.times { create :service, city_id: 18_030 }
        create :service, city_id: 18_031
        create :service, city_id: 18_032

        get :index, params: { city_id: [18_031, 18_032] }

        expect(assigns(:services).size).to eq 2
      end

      it "filters by category" do
        2.times { create :service, category: SERVICE_SUBCATEGORIES.keys.first }
        create :service, category: SERVICE_SUBCATEGORIES.keys.second

        get :index, params: { category: SERVICE_SUBCATEGORIES.keys.first }

        expect(assigns(:services).size).to eq 2
      end

      it "filters by subcategory" do
        2.times { create :service, subcategory: "Салоны красоты" }
        create :service, subcategory: "other"

        get :index, params: { subcategory: "Салоны красоты" }

        expect(assigns(:services).size).to eq 2
      end

      it "returns records according to priority" do
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
