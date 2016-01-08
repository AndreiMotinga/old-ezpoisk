require "rails_helper"

describe Jobs::JobAgenciesController do
  it "renders the index template and assigns @job_agencies" do
    2.times { create :job_agency, :active }

    get :index

    expect(response).to render_template(:index)
    expect(assigns(:job_agencies).size).to eq 2
  end

  it "return only active models" do
    2.times { create :job_agency, :active }
    create :job_agency, active: false

    get :index

    expect(assigns(:job_agencies).size).to eq 2
  end

  describe "#filter" do
    it "filters by state_id" do
      new_york = create(:state, name: "New York")
      alabama = create(:state, name: "Alabama")
      2.times { create :job_agency, :active, state_id: alabama.id }
      create :job_agency, :active,  state_id: new_york.id

      get :index, state_id: new_york.id

      expect(assigns(:job_agencies).size).to eq 1
    end

    it "filters by city_id" do
      brooklyn = create(:city, name: "Brooklyn")
      bronx = create(:city, name: "Bronx")
      queens  = create(:city, name: "Queens")
      2.times { create :job_agency, :active, city_id: queens.id }
      create :job_agency, :active,  city_id: brooklyn.id
      create :job_agency, :active, city_id: bronx.id

      get :index, city_id: [brooklyn.id, bronx.id]

      expect(assigns(:job_agencies).size).to eq 2
    end
  end

  describe "GET @show" do
    it "renders the show template and assigns @job_agency if its active" do
      job_agency = create(:job_agency, :active)

      get :show, id: job_agency.id

      expect(response).to render_template(:show)
      expect(assigns(:job_agency)).to eq job_agency
      expect(flash[:alert]).to be nil
    end

    it "redirects to 404 if it's inactive" do
      job_agency = create(:job_agency, active: false)

      get :show, id: job_agency.id

      expect(response).to redirect_to real_estate_re_agencies_path
      expect(flash[:alert]).to eq I18n.t(:post_not_found)
    end
  end
end
