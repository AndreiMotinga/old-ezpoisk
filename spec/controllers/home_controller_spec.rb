require "rails_helper"

describe HomeController do
  describe "#index" do
    it "renders home page and assigns @posts" do
      5.times { create :post }
      get :index

      expect(response).to render_template(:index)
      expect(assigns(:posts).size).to eq 5
    end
  end
end
