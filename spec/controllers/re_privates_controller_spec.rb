require "rails_helper"

describe RePrivatesController do
  before { sign_in(@user = create(:user)) }

  describe "GET #index" do
    it "renders the index template, assigns @re_privates, and schedules job" do
      2.times { create :re_private }

      get :index

      re_privates = assigns(:re_privates)
      expect(response).to render_template(:index)
      expect(re_privates.size).to eq 2
      expect(IncreaseImpressionsJob.jobs.size).to eq 1
      job = IncreaseImpressionsJob.jobs.first
      expect(job["args"].first).to eq re_privates.pluck :id
      expect(job["args"].second).to eq "RePrivate"
    end

    it "return only active models" do
      2.times { create :re_private }
      create :re_private, active: false

      get :index

      expect(assigns(:re_privates).size).to eq 2
    end

    describe "search" do
      it "filters by state_id" do
        2.times { create :re_private, state_id: 1 }
        create :re_private, state_id: 32

        get :index, params: { state_id: 32 }

        expect(assigns(:re_privates).size).to eq 1
      end

      it "filters by city_id" do
        2.times { create :re_private, city_id: 18_030 }
        create :re_private,  city_id: 18_031
        create :re_private, city_id: 18_032

        get :index, params: { city_id: [18_032, 18_031] }

        expect(assigns(:re_privates).size).to eq 2
      end

      it "filters by fee" do
        create :re_private, fee: false
        create :re_private, fee: true

        get :index, params: { fee: true }

        expect(assigns(:re_privates).size).to eq 1
      end

      it "filters by post_type" do
        create :re_private, post_type: "sale"
        create :re_private, post_type: "rent"

        get :index, params: { post_type: "sale" }

        expect(assigns(:re_privates).size).to eq 1
      end

      it "filters by duration" do
        create :re_private, duration: "hour"
        create :re_private, duration: "day"
        create :re_private, duration: "month"

        get :index, params: { duration: "day" }

        expect(assigns(:re_privates).size).to eq 1
      end

      it "filters by rooms" do
        create :re_private, rooms: "комната"
        create :re_private, rooms: 2
        create :re_private, rooms: 3

        get :index, params: { rooms: "комната" }

        expect(assigns(:re_privates).size).to eq 1
      end

      it "filters by baths" do
        create :re_private, baths: 1
        create :re_private, baths: 2
        create :re_private, baths: 3

        get :index, params: { baths: 2 }

        expect(assigns(:re_privates).size).to eq 2
      end

      it "filters by space" do
        create :re_private, space: 1000
        create :re_private, space: 2000
        create :re_private, space: 3000

        get :index, params: { space: 2000 }

        expect(assigns(:re_privates).size).to eq 2
      end

      it "filters by minimum price" do
        create :re_private, price: 1000
        create :re_private, price: 2000
        create :re_private, price: 3000

        get :index, params: { min_price: 2000 }

        expect(assigns(:re_privates).size).to eq 2
      end

      it "filters by maximum price" do
        create :re_private, price: 1000
        create :re_private, price: 2000
        create :re_private, price: 3000

        get :index, params: { max_price: 1000 }

        expect(assigns(:re_privates).size).to eq 1
      end

      context "sorts records" do
        context "by price" do
          it "in asc order" do
            create :re_private, price: 200
            create :re_private, price: 100
            create :re_private, price: 300

            get :index, params: { sorted: "price asc" }
            expect(assigns(:re_privates).pluck(:price)).to eq [100, 200, 300]
          end
          it "in desc order" do
            create :re_private, price: 200
            create :re_private, price: 100
            create :re_private, price: 300

            get :index, params: { sorted: "price desc" }
            expect(assigns(:re_privates).pluck(:price)).to eq [300, 200, 100]
          end
        end

        context "by space" do
          it "in asc order" do
            create :re_private, space: 200
            create :re_private, space: 100
            create :re_private, space: 300

            get :index, params: { sorted: "space asc" }
            expect(assigns(:re_privates).pluck(:space)).to eq [100, 200, 300]
          end
          it "in desc order" do
            create :re_private, space: 200
            create :re_private, space: 100
            create :re_private, space: 300

            get :index, params: { sorted: "space desc" }
            expect(assigns(:re_privates).pluck(:space)).to eq [300, 200, 100]
          end
        end

        context "by date" do
          it "newest first" do
            create :re_private, space: 200
            create :re_private, space: 100
            create :re_private, space: 300

            get :index, params: { sorted: "updated_at asc" }
            expect(assigns(:re_privates).pluck(:space)).to eq [200, 100, 300]
          end
        end
      end
    end
  end

  describe "GET #show" do
    it "renders the show template and assigns @re_private if its active" do
      re_private = create(:re_private)

      get :show, params: { id: re_private.id }

      expect(response).to render_template(:show)
      expect(assigns(:re_private)).to eq re_private
      expect(flash[:alert]).to be nil
      expect(IncreaseVisitsJob.jobs.size).to eq 1
    end

    it "redirects re_privates_path" do
      re_private = create(:re_private, active: false)

      get :show, params: { id: re_private.id }

      expect(response).to redirect_to re_privates_path
      expect(flash[:alert]).to eq I18n.t(:post_not_found)
      expect(IncreaseVisitsJob.jobs.size).to eq 0
    end

    it "doesn't increase visits if user visits his listsing" do
      user = create :user
      sign_in(user)
      re_private = create(:re_private, user: user)

      get :show, params: { id: re_private.id }

      expect(IncreaseVisitsJob.jobs.size).to eq 0
    end
  end
end
