require "rails_helper"

describe PostsController do
  describe "GET #index" do
    it "assigns @posts" do
      2.times { create :post }

      get :index
      result = Post.all

      expect(result.size).to eq 2
    end
  end

  describe "GET #show" do
    it "assings @post" do
      post = create(:post)

      get :show, id: post.slug

      expect(assigns(:post)).to eq post
    end
  end
end
