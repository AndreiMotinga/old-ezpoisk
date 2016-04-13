require "rails_helper"

describe PostsController do
  describe "GET #index" do
    it "assigns @posts" do
      first = create :post
      second = create :post
      get :index
      expect(assigns(:posts)).to eq([second, first])
    end
  end

  describe "GET #show" do
    it "assings @post" do
      post = create :post

      get :show, id: post.slug

      expect(assigns(:post)).to eq post
    end
  end
end
