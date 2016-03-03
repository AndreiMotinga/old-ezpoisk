require "rails_helper"

describe NewsController do
  describe "GET #index" do
    it "assigns @posts" do
      first = create :post, show_on_homepage: true
      second = create :post, show_on_homepage: true
      get :index
      expect(assigns(:news_posts)).to eq([second, first])
    end

    it "return posts by category" do
      2.times { create :post, category: NEWS_CATEGORIES.keys.first }
      create :post, category: NEWS_CATEGORIES.keys.second, show_on_homepage: true

      get :index, category: NEWS_CATEGORIES.keys.second

      expect(assigns(:news_posts).size).to eq 1
    end
  end

  describe "GET #show" do
    it "assings @post" do
      post = create :post

      get :show, id: post.id

      expect(assigns(:post)).to eq post
    end
  end

  # describe "GET #edit" do
  #   it "renders new template and assigns :new" do
  #     sign_in(user = create(:user))
  #     post = create(:post, user: user)
  #     get :edit, id: post.id
  #
  #     expect(response).to render_template(:edit)
  #     expect(assigns(:post)).to eq post
  #   end
  # end
  #
  # describe "PUT #update" do
  #   it "updates the record" do
  #     sign_in(user = create(:user))
  #     post = create :post, user: user
  #     attrs = attributes_for(:post)
  #
  #     put :update, id: post.id, post: attrs
  #
  #     expect(response).to redirect_to(edit_news_path post)
  #     expect(flash[:notice]).to eq I18n.t(:post_saved)
  #     post.reload
  #
  #     expect(post.title).to eq attrs[:title]
  #     expect(post.body).to eq attrs[:body]
  #     expect(post.category).to eq attrs[:category]
  #   end
  # end
end
