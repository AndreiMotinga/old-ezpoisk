require "rails_helper"

describe NewsController do
  describe "#index" do
    it "assigns @posts" do
      first = create :post
      second = create :post
      get :index
      expect(assigns(:posts)).to eq([second, first])
    end

    it "return posts by category" do
      2.times { create :post, category: NEWS_CATEGORIES.first }
      create :post, category: NEWS_CATEGORIES.second

      get :index, category: NEWS_CATEGORIES.first

      expect(assigns(:posts).size).to eq 2
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
