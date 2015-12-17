require "rails_helper"

describe NewsController do
  describe "#index" do
    it "assigns @posts" do
      first = double("post")
      second = double("post")
      allow(Post).to receive(:news).and_return([second, first])
      get :index
      expect(assigns(:posts)).to eq([second, first])
    end
  end
end
