require "rails_helper"

describe ServicesController do
  describe "GET #index" do
    it "renders the index template and assigns @services" do
      2.times { create :service }

      get :index

      expect(response).to render_template(:index)
      expect(assigns(:services).size).to eq 2
    end

    it "return only active models" do
      2.times { create :service }
      create :service, active_until: nil

      get :index

      expect(assigns(:services).size).to eq 3
    end

    describe "#filter" do
      it "filters by state_id" do
        2.times { create :service, state_id: 1 }
        create :service, state_id: 32

        get :index, state_id: 32

        expect(assigns(:services).size).to eq 1
      end

      it "filters by city_id" do
        2.times { create :service, city_id: 18_030 }
        create :service, city_id: 18_031
        create :service, city_id: 18_032

        get :index, city_id: [18_031, 18_032]

        expect(assigns(:services).size).to eq 2
      end

      it "filters by category" do
        2.times { create :service, category: SERVICE_CATEGORIES.keys.first }
        create :service, category: SERVICE_CATEGORIES.keys.second

        get :index, category: SERVICE_CATEGORIES.keys.first

        expect(assigns(:services).size).to eq 2
      end

      it "filters by subcategory" do
        2.times { create :service, subcategory: "Салоны красоты" }
        create :service, subcategory: "other"

        get :index, subcategory: "Салоны красоты"

        expect(assigns(:services).size).to eq 2
      end
    end
  end

  describe "GET @show" do
    it "renders the show template and assigns @service if its active" do
      service = create(:service)

      get :show, id: service.id

      expect(response).to render_template(:show)
      expect(assigns(:service)).to eq service
      expect(flash[:alert]).to be nil
    end

    # uncomment when services are paid
    # it "redirects to 404 if it's inactive" do
    #   service = create(:service, active_until: nil)
    #
    #   get :show, id: service.id
    #
    #   expect(response).to redirect_to services_path
    #   expect(flash[:alert]).to eq I18n.t(:post_not_found)
    # end
  end
end
