require "rails_helper"

describe ReCommercialsController do
  before { sign_in(@user = create(:user)) }

  describe "GET #index" do
    it "renders the index template, assigns @re_commercials, schedules job" do
      2.times { create :re_commercial, :active }

      get :index

      rc = assigns(:re_commercials)
      expect(response).to render_template(:index)
      expect(rc.size).to eq 2
      expect(IncreaseImpressionsJob.jobs.size).to eq 1
      job = IncreaseImpressionsJob.jobs.first
      expect(job["args"].first).to eq rc.pluck :id
      expect(job["args"].second).to eq "ReCommercial"
    end

    it "return only active models" do
      2.times { create :re_commercial, :active }
      create :re_commercial, active: false

      get :index

      expect(assigns(:re_commercials).size).to eq 2
    end

    describe "search" do
      it "filters by state_id" do
        2.times { create :re_commercial, :active, state_id: 1 }
        create :re_commercial, :active,  state_id: 32

        get :index, params: { state_id: 32 }

        expect(assigns(:re_commercials).size).to eq 1
      end

      it "filters by city_id" do
        2.times { create :re_commercial, :active, city_id: 18_030 }
        create :re_commercial, :active,  city_id: 18_031
        create :re_commercial, :active, city_id: 18_032

        get :index, params: { city_id: [18_031, 18_032] }

        expect(assigns(:re_commercials).size).to eq 2
      end

      it "filters by post_type" do
        create :re_commercial, :active, post_type: "sale"
        create :re_commercial, :active, post_type: "rent"

        get :index, params: { post_type: "sale" }

        expect(assigns(:re_commercials).size).to eq 1
      end

      it "filters by space" do
        create :re_commercial, :active, space: 1000
        create :re_commercial, :active, space: 2000
        create :re_commercial, :active, space: 3000

        get :index, params: { space: 2000 }

        expect(assigns(:re_commercials).size).to eq 2
      end

      it "filters by minimum price" do
        create :re_commercial, :active, price: 1000
        create :re_commercial, :active, price: 2000
        create :re_commercial, :active, price: 3000

        get :index, params: { min_price: 2000 }

        expect(assigns(:re_commercials).size).to eq 2
      end

      it "filters by maximum price" do
        create :re_commercial, :active, price: 1000
        create :re_commercial, :active, price: 2000
        create :re_commercial, :active, price: 3000

        get :index, params: { max_price: 1000 }

        expect(assigns(:re_commercials).size).to eq 1
      end

      context "sorts records" do
        context "by price" do
          it "in asc order" do
            create :re_commercial, :active, price: 200
            create :re_commercial, :active, price: 100
            create :re_commercial, :active, price: 300

            get :index, params: { sorted: "price asc" }
            expect(assigns(:re_commercials).pluck(:price)).to eq [100, 200, 300]
          end
          it "in desc order" do
            create :re_commercial, :active, price: 200
            create :re_commercial, :active, price: 100
            create :re_commercial, :active, price: 300

            get :index, params: { sorted: "price desc" }
            expect(assigns(:re_commercials).pluck(:price)).to eq [300, 200, 100]
          end
        end

        context "by space" do
          it "in asc order" do
            create :re_commercial, :active, space: 200
            create :re_commercial, :active, space: 100
            create :re_commercial, :active, space: 300

            get :index, params: { sorted: "space asc" }
            expect(assigns(:re_commercials).pluck(:space)).to eq [100, 200, 300]
          end
          it "in desc order" do
            create :re_commercial, :active, space: 200
            create :re_commercial, :active, space: 100
            create :re_commercial, :active, space: 300

            get :index, params: { sorted: "space desc" }
            expect(assigns(:re_commercials).pluck(:space)).to eq [300, 200, 100]
          end
        end

        context "by date" do
          it "newest first" do
            create :re_commercial, :active, space: 200
            create :re_commercial, :active, space: 100
            create :re_commercial, :active, space: 300

            get :index, params: { sorted: "updated_at asc" }
            expect(assigns(:re_commercials).pluck(:space)).to eq [200, 100, 300]
          end
        end
      end
    end
  end

  describe "GET @show" do
    it "renders the show template and assigns @re_commercial if its active" do
      re_commercial = create(:re_commercial, :active)

      get :show, params: { id: re_commercial.id }

      expect(response).to render_template(:show)
      expect(assigns(:re_commercial)).to eq re_commercial
      expect(flash[:alert]).to be nil
    end

    it "redirects to 404 if it's inactive" do
      re_commercial = create(:re_commercial, active: false)

      get :show, params: { id: re_commercial.id }

      expect(response).to redirect_to re_commercials_path
      expect(flash[:alert]).to eq I18n.t(:post_not_found)
    end
  end
end
