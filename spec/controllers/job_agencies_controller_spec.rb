require "rails_helper"

describe JobAgenciesController do
  it "renders the index template and assigns @job_agencies" do
    get :index

    expect(response).to be_success
    expect(response).to render_template(:index)
  end

  it "return only active models" do
    2.times { create :service, :job_agency }
    create :service, :job_agency, active_until: nil

    get :index

    expect(assigns(:job_agencies).size).to eq 3
  end

  describe "#filter" do
    it "filters by state_id" do
      2.times { create :service, :job_agency, state_id: 1 }
      create :service, :job_agency, state_id: 32

      get :index, state_id: 32

      expect(assigns(:job_agencies).size).to eq 1
    end

    it "filters by city_id" do
      2.times { create :service, :job_agency, city_id: 18_030 }
      create :service, :job_agency, city_id: 18_031
      create :service, :job_agency, city_id: 18_032

      get :index, city_id: [18_031, 18_032]

      expect(assigns(:job_agencies).size).to eq 2
    end
  end

  describe "GET @show" do
    it "renders the show template and assigns @job_agency if its active" do
      job_agency = create(:service, :job_agency)

      get :show, id: job_agency.id

      expect(response).to render_template(:show)
      expect(assigns(:job_agency)).to eq job_agency
      expect(flash[:alert]).to be nil
    end

    # uncomment when services are paid
    # it "redirects to 404 if it's inactive" do
    #   job_agency = create(:service, :job_agency, active_until: nil)
    #
    #   get :show, id: job_agency.id
    #
    #   expect(response).to redirect_to job_agencies_path
    #   expect(flash[:alert]).to eq I18n.t(:post_not_found)
    # end
  end
end
