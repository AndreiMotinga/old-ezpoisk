require "rails_helper"

describe RealEstate::ReAgenciesController do
  it "renders the index template and assigns @re_agencies" do
    2.times { create :re_agency, :active }

    get :index

    expect(response).to render_template(:index)
    expect(assigns(:re_agencies).size).to eq 2
  end

  it "return only active models" do
    2.times { create :re_agency, :active }
    create :re_agency, active: false

    get :index

    expect(assigns(:re_agencies).size).to eq 2
  end

  describe "search" do
      it "returns geoscoped records" do
        searched_record = create :re_agency,
                                 :active,
                                 lat: 40.602088,
                                 lng: -73.954382
        create :re_agency, :active
        create :re_agency, :active

        get :index, within: 1, origin: "1970 East 18th str Brooklyn New York"

        expect(assigns(:re_agencies).size).to eq 1
        expect(assigns(:re_agencies)).to eq [searched_record]
      end
  end
end
