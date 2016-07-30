require "rails_helper"

describe ProfilesController do
  describe "#show" do
    it "is success and assigns @user" do
      user = create :user

      get :show, params: { id: user.id }

      expect(assigns(:user)).to be_a User
      expect(response).to be_success
    end
  end

  describe "#posts" do
    it "is success and assigns posts" do
      user = create :user
      2.times { create :post, user: user }

      get :posts, params: { id: user.id }
      posts = assigns(:posts)

      expect(response).to be_success
      expect(posts.count).to eq 2
    end
  end

  describe "#listings" do
    it "is success and assigns listings" do
      user = create :user
      rp = create :re_private, user: user
      rp.create_entry user: user
      sale = create :sale, user: user
      sale.create_entry user: user

      get :listings, params: { id: user.id }
      listings = assigns(:listings)

      expect(response).to be_success
      expect(listings.size).to eq 2
    end
  end

  describe "#answers" do
    it "is success and assigns answers" do
      user = create :user
      2.times { create :answer, user: user }

      get :answers, params: { id: user.id }
      answers = assigns(:answers)

      expect(response).to be_success
      expect(answers.size).to eq 2
    end
  end
end
