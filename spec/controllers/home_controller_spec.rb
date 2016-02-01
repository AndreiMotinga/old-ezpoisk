require "rails_helper"

describe HomeController do
  describe "#index" do
    it "renders home page and assigns @homepage" do
      get :index

      expect(response).to render_template(:index)
      expect(assigns(:homepage)).to be_a Homepage
    end
  end
end
