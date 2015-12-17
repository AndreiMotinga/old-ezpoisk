require "rails_helper"

describe NewsController do
  describe "#index" do
    it "assigns @posts" do
      first = create :post
      second = create :post
      get :index
      expect(assigns(:posts)).to eq([second, first])
    end
  end

  describe "#show" do
    it "assings @post" do
      post = create :post

      get :show, id: post.id

      expect(assigns(:post)).to eq post
    end
  end
end
