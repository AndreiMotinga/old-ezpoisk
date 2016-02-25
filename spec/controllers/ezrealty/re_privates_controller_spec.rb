require "rails_helper"

describe Ezrealty::RePrivatesController do
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
        create :re_private, :active, rooms: "комната"
        create :re_private, :active, rooms: 2
        create :re_private, :active, rooms: 3

        get :index, rooms: "комната"

        expect(assigns(:re_privates).size).to eq 1
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

      context "sorts records" do
        context "by price" do
          it "in asc order" do
            create :re_private, :active, price: 200
            create :re_private, :active, price: 100
            create :re_private, :active, price: 300

            get :index, sorted: "price asc"
            expect(assigns(:re_privates).pluck(:price)).to eq [100, 200, 300]
          end
          it "in desc order" do
            create :re_private, :active, price: 200
            create :re_private, :active, price: 100
            create :re_private, :active, price: 300

            get :index, sorted: "price desc"
            expect(assigns(:re_privates).pluck(:price)).to eq [300, 200, 100]
          end
        end

        context "by space" do
          it "in asc order" do
            create :re_private, :active, space: 200
            create :re_private, :active, space: 100
            create :re_private, :active, space: 300

            get :index, sorted: "space asc"
            expect(assigns(:re_privates).pluck(:space)).to eq [100, 200, 300]
          end
          it "in desc order" do
            create :re_private, :active, space: 200
            create :re_private, :active, space: 100
            create :re_private, :active, space: 300

            get :index, sorted: "space desc"
            expect(assigns(:re_privates).pluck(:space)).to eq [300, 200, 100]
          end
        end

        context "by date" do
          it "newest first" do
            create :re_private, :active, space: 200
            create :re_private, :active, space: 100
            create :re_private, :active, space: 300

            get :index, sorted: "updated_at asc"
            expect(assigns(:re_privates).pluck(:space)).to eq [200, 100, 300]
          end
        end
      end
    end
  end

  describe "GET #show" do
    it "renders the show template and assigns @re_private if its active" do
      re_private = create(:re_private, :active)

      get :show, id: re_private.id

      expect(response).to render_template(:show)
      expect(assigns(:re_private)).to eq re_private
      expect(flash[:alert]).to be nil
    end

    it "redirects to 404 if it's inactive" do
      re_private = create(:re_private, active: false)

      get :show, id: re_private.id

      expect(response).to redirect_to ezrealty_re_privates_path
      expect(flash[:alert]).to eq I18n.t(:post_not_found)
    end
  end
end
