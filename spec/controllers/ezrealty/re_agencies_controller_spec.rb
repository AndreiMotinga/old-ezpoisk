require "rails_helper"

describe Ezrealty::ReAgenciesController do
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

  describe "GET @show" do
    it "renders the show template and assigns @re_agency if its active" do
      re_agency = create(:re_agency, :active)

      get :show, id: re_agency.id

      expect(response).to render_template(:show)
      expect(assigns(:re_agency)).to eq re_agency
      expect(flash[:alert]).to be nil
    end

    it "redirects to 404 if it's inactive" do
      re_agency = create(:re_agency, active: false)

      get :show, id: re_agency.id

      expect(response).to redirect_to ezrealty_re_agencies_path
      expect(flash[:alert]).to eq I18n.t(:post_not_found)
    end
  end
end
