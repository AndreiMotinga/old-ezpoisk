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

  describe "#show" do
    it "assings @post" do
      post = instance_double("post", id: "1")
      allow(Post).to receive(:find).with(post.id).and_return([post])

      get :show, id: post.id

      expect(assigns(:post)).to eq([post])
    end
  end
end
