require "rails_helper"

describe SalesController do
  describe "GET #index" do
    it "renders the index template, assigns @sales, schedules job" do
      2.times { create :sale }

      get :index

      sales = assigns(:sales)
      expect(response).to render_template(:index)
      expect(sales.size).to eq 2
      expect(IncreaseImpressionsJob.jobs.size).to eq 1
      job = IncreaseImpressionsJob.jobs.first
      expect(job["args"].first).to eq sales.pluck :id
      expect(job["args"].second).to eq "Sale"
    end

    it "return only active models" do
      2.times { create :sale }
      create :sale, active: false

      get :index

      expect(assigns(:sales).size).to eq 2
    end

    describe "#filter" do
      it "filters by term" do
        first = create :sale, title: "Computer table"
        second = create :sale, text: "Computer desk"
        create :sale, title: "Supercar", text: "Foobar"

        get :index, params: { term: "comput" }
        sales = assigns(:sales)

        expect(sales.map(&:title)).to match_array [first.title, second.title]
        expect(sales.size).to eq 2
      end

      context "filters by category" do
        it "with existing records" do
          2.times { create :sale, category: Sale::CATEGORIES.second }
          create :sale, category: Sale::CATEGORIES.third

          get :index, params: { category: Sale::CATEGORIES.second }

          expect(assigns(:sales).size).to eq 2
        end

        it "with non existing records" do
          2.times { create :sale, category: Sale::CATEGORIES.second }
          create :sale, category: Sale::CATEGORIES.third

          get :index, params: { category: Sale::CATEGORIES.fourth }

          expect(assigns(:sales).size).to eq 0
        end
      end
    end
  end

  describe "GET @show" do
    it "renders the show template and assigns @sale if its active" do
      sale = create(:sale)

      get :show, params: { id: sale.id }

      expect(response).to render_template(:show)
      expect(assigns(:sale)).to eq sale
      expect(flash[:alert]).to be nil
    end

    it "redirects to 404 if it's inactive" do
      sale = create(:sale, active: false)

      get :show, params: { id: sale.id }

      expect(response).to redirect_to sales_path
      expect(flash[:alert]).to eq I18n.t(:post_not_found)
    end
  end
end
