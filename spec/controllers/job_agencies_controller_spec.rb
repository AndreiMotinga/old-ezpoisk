require "rails_helper"

describe JobAgenciesController do
  it "renders the index template and assigns @job_agencies" do
    get :index

    expect(response).to be_success
    expect(response).to render_template(:index)
  end

  it "return only active models" do
    2.times { create :service, :job_agency, :active }
    create :service, :job_agency

    get :index

    expect(assigns(:job_agencies).size).to eq 2
  end

  describe "#filter" do
    it "filters by state_id" do
      2.times { create :service, :job_agency, :active, state_id: 1 }
      create :service, :job_agency, :active, state_id: 32

      get :index, state_id: 32

      expect(assigns(:job_agencies).size).to eq 1
    end

    it "filters by city_id" do
      2.times { create :service, :job_agency, :active, city_id: 18_030 }
      create :service, :job_agency, :active, city_id: 18_031
      create :service, :job_agency, :active, city_id: 18_032

      get :index, city_id: [18_031, 18_032]

      expect(assigns(:job_agencies).size).to eq 2
    end
  end
end
