require "rails_helper"

describe SalesController do
  describe "GET #index" do
    it "renders the index template and assigns @sales" do
      2.times { create :sale, :active }

      get :index

      expect(response).to render_template(:index)
      expect(assigns(:sales).size).to eq 2
    end

    it "return only active models" do
      2.times { create :sale, :active }
      create :sale, active: false

      get :index

      expect(assigns(:sales).size).to eq 2
    end

    # external api calls
    # describe "search" do
    #   it "returns geoscoped records" do
    #     searched_record = create :sale,
    #                              :active,
    #                              lat: 40.602088,
    #                              lng: -73.954382
    #     create :sale, :active
    #     create :sale, :active
    #
    #     get :index, within: 1, origin: "1970 East 18th str Brooklyn New York"
    #
    #     expect(assigns(:sales).size).to eq 1
    #     expect(assigns(:sales)).to eq [searched_record]
    #   end
    # end

    describe "#filter" do
      it "filters by state_id" do
        new_york = create(:state, name: "New York")
        alabama = create(:state, name: "Alabama")
        2.times { create :sale, :active, state_id: alabama.id }
        create :sale, :active,  state_id: new_york.id

        get :index, state_id: new_york.id

        expect(assigns(:sales).size).to eq 1
      end

      it "filters by city_id" do
        brooklyn = create(:city, name: "Brooklyn")
        bronx = create(:city, name: "Bronx")
        queens  = create(:city, name: "Queens")
        2.times { create :sale, :active, city_id: queens.id }
        create :sale, :active,  city_id: brooklyn.id
        create :sale, :active, city_id: bronx.id

        get :index, city_id: [brooklyn.id, bronx.id]

        expect(assigns(:sales).size).to eq 2
      end

      it "filters by keyword" do
        first = create :sale, :active, title: "Computer table"
        second = create :sale, :active, description: "Computer desk"
        create :sale, :active, title: "Supercar", description: "Foobar"

        get :index, keyword: "comput"
        sales = assigns(:sales)

        expect(sales.map(&:title)).to match_array [first.title, second.title]
        expect(sales.size).to eq 2
      end

      context "filters by category" do
        it "with existing records" do
          2.times { create :sale, :active, category: SALE_CATEGORIES.second }
          create :sale, :active, category: SALE_CATEGORIES.third

          get :index, category: SALE_CATEGORIES.second

          expect(assigns(:sales).size).to eq 2
        end

        it "with non existing records" do
          2.times { create :sale, :active, category: SALE_CATEGORIES.second }
          create :sale, :active, category: SALE_CATEGORIES.third

          get :index, category: SALE_CATEGORIES.fourth

          expect(assigns(:sales).size).to eq 0
        end
      end
    end
  end

  describe "GET @show" do
    it "renders the show template and assigns @sale if its active" do
      sale = create(:sale, :active)

      get :show, id: sale.id

      expect(response).to render_template(:show)
      expect(assigns(:sale)).to eq sale
      expect(flash[:alert]).to be nil
    end

    it "redirects to 404 if it's inactive" do
      sale = create(:sale, active: false)

      get :show, id: sale.id

      expect(response).to redirect_to sales_path
      expect(flash[:alert]).to eq I18n.t(:post_not_found)
    end
  end
end
