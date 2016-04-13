require "rails_helper"

describe ReFinancesController do
  it "renders the index template and assigns @re_finances" do
    2.times { create :re_finance }

    get :index

    expect(response).to render_template(:index)
    expect(assigns(:re_finances).size).to eq 2
  end

  it "return only active models" do
    2.times { create :re_finance }
    create :re_finance, active: false

    get :index

    expect(assigns(:re_finances).size).to eq 2
  end

  describe "GET @show" do
    it "renders the show template and assigns @re_finance if its active" do
      re_finance = create(:re_finance)

      get :show, id: re_finance.id

      expect(response).to render_template(:show)
      expect(assigns(:re_finance)).to eq re_finance
    end

    it "redirects to re_finances_path if it's inactive" do
      re_finance = create(:re_finance, active: false)

      get :show, id: re_finance.id

      expect(response).to redirect_to re_finances_path
      expect(flash[:alert]).to eq I18n.t(:post_not_found)
    end
  end
end
