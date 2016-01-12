require "rails_helper"

describe NewsController do
  describe "GET #index" do
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

  describe "GET #show" do
    it "assings @post" do
      post = create :post

      get :show, id: post.id

      expect(assigns(:post)).to eq post
    end
  end

  describe "GET #new" do
    context "user is author" do
      it "renders new template and assigns :new" do
        sign_in(create(:user))
        get :new
        expect(response).to render_template(:new)
        expect(assigns(:post)).to be_a(Post)
      end
    end
  end

  # describe "POST #create" do
  #   it "creates post" do
  #     sign_in(user = create(:user))
  #     attrs = attributes_for(:post)
  #
  #     post :create, post: attrs
  #     news_post = assigns(:post)
  #
  #     expect(response).to redirect_to(edit_news_path(news_post))
  #     expect(flash[:notice]).to eq I18n.t(:post_saved)
  #     expect(news_post.title).to eq attrs[:title]
  #     expect(news_post.body).to eq attrs[:body]
  #     expect(news_post.category).to eq attrs[:category]
  #     expect(news_post.user).to eq user
  #   end
  # end
  #
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
