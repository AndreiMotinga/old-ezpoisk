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
      post = double(:post, slug: "foo-bar")
      allow(Post).to receive(:find).with(post.slug).and_return(post)
      allow(post).to receive(:increment!).with(:impressions_count)

      get :show, id: post.slug

      expect(assigns(:post)).to eq post
      expect(Post).to have_received(:find).with(post.slug)
      expect(post).to have_received(:increment!).with(:impressions_count)
    end
  end
end
