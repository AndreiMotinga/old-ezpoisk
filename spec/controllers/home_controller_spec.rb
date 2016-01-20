require "rails_helper"

describe HomeController do
  describe "#index" do
    it "renders home page and assigns @posts" do
      create :post, :main
      5.times { create :post, :show_on_homepage }
      get :index

      expect(response).to render_template(:index)
      expect(assigns(:posts).size).to eq 5
    end
  end
end
