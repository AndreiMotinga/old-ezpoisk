require "rails_helper"

describe HomeController do
  describe "GET index" do
    render_views
    it "renders home page and assigns @homepage" do
      get :index

      expect(response).to render_template(:index)
      expect(assigns(:homepage)).to be_a Homepage
    end
  end

  describe "GET about" do
    render_views
    it "renders home page and assigns @homepage" do
      get :about

      expect(response).to render_template(:about)
      expect(assigns(:feedback)).to be_a Feedback
    end
  end
end
