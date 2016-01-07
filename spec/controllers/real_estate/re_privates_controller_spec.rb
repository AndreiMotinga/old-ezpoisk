require "rails_helper"

describe RealEstate::RePrivatesController do
  before { sign_in(@user = create(:user)) }

  describe "GET #index" do
    it "renders the index template and assigns @re_privates" do
      2.times { create :re_private, :active }

      get :index

      expect(response).to render_template(:index)
      expect(assigns(:re_privates).size).to eq 2
    end

    it "return only active models" do
      2.times { create :re_private, :active }
      create :re_private, active: false

      get :index

      expect(assigns(:re_privates).size).to eq 2
    end

    describe "search" do
      it "filters by state_id" do
        new_york = create(:state, name: "New York")
        alabama = create(:state, name: "Alabama")
        2.times { create :re_private, :active, state_id: alabama.id }
        create :re_private, :active,  state_id: new_york.id

        get :index, state_id: new_york.id

        expect(assigns(:re_privates).size).to eq 1
      end

      it "filters by city_id" do
        brooklyn = create(:city, name: "Brooklyn")
        bronx = create(:city, name: "Bronx")
        queens  = create(:city, name: "Queens")
        2.times { create :re_private, :active, city_id: queens.id }
        create :re_private, :active,  city_id: brooklyn.id
        create :re_private, :active, city_id: bronx.id

        get :index, city_id: [brooklyn.id, bronx.id]

        expect(assigns(:re_privates).size).to eq 2
      end

      it "filters by fee" do
        create :re_private, :active, fee: false
        create :re_private, :active, fee: true

        get :index, fee: true

        expect(assigns(:re_privates).size).to eq 1
      end

      it "filters by post_type" do
        create :re_private, :active, post_type: "sale"
        create :re_private, :active, post_type: "rent"

        get :index, post_type: "sale"

        expect(assigns(:re_privates).size).to eq 1
      end

      it "filters by duration" do
        create :re_private, :active, duration: "hour"
        create :re_private, :active, duration: "day"
        create :re_private, :active, duration: "month"

        get :index, duration: "day"

        expect(assigns(:re_privates).size).to eq 1
      end

      it "filters by rooms" do
        create :re_private, :active, rooms: 1
        create :re_private, :active, rooms: 2
        create :re_private, :active, rooms: 3

        get :index, rooms: 2

        expect(assigns(:re_privates).size).to eq 2
      end

      it "filters by baths" do
        create :re_private, :active, baths: 1
        create :re_private, :active, baths: 2
        create :re_private, :active, baths: 3

        get :index, baths: 2

        expect(assigns(:re_privates).size).to eq 2
      end

      it "filters by space" do
        create :re_private, :active, space: 1000
        create :re_private, :active, space: 2000
        create :re_private, :active, space: 3000

        get :index, space: 2000

        expect(assigns(:re_privates).size).to eq 2
      end

      it "filters by minimum price" do
        create :re_private, :active, price: 1000
        create :re_private, :active, price: 2000
        create :re_private, :active, price: 3000

        get :index, min_price: 2000

        expect(assigns(:re_privates).size).to eq 2
      end

      it "filters by maximum price" do
        create :re_private, :active, price: 1000
        create :re_private, :active, price: 2000
        create :re_private, :active, price: 3000

        get :index, max_price: 1000

        expect(assigns(:re_privates).size).to eq 1
      end

      it "returns geoscoped records" do
        searched_record = create :re_private,
                                 :active,
                                 lat: 40.602088,
                                 lng: -73.954382
        create :re_private, :active
        create :re_private, :active

        get :index, within: 1, origin: "1970 East 18th str Brooklyn New York"

        expect(assigns(:re_privates).size).to eq 1
        expect(assigns(:re_privates)).to eq [searched_record]
      end
    end

    # todo: test sorting
  end

  describe "GET #show" do
    it "renders the show template and assigns @re_private" do
      re_private = create(:re_private)

      get :show, id: re_private.id

      expect(response).to render_template(:show)
      expect(assigns(:re_private)).to eq re_private
    end
  end
end
