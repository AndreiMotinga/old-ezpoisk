require "rails_helper"

describe Dashboard::PostsController do
  before { sign_in(@user = create(:user)) }

  describe "POST #create" do
    it "creates record and entry" do

      attrs = attributes_for(:post)

      post :create, post: attrs
      article = assigns(:post)

      expect(response).to redirect_to(
        edit_dashboard_post_path(article)
      )
      expect(article.title).to eq attrs[:title]
      expect(article.user).to eq @user
      expect(article.text).to eq attrs[:text]

      entry = Entry.last
      expect(Entry.count).to eq 1
      expect(entry.enterable_id).to eq article.id
      expect(entry.enterable_type).to eq article.class.to_s
    end
  end


  describe "DELETE #destroy" do
    it "removes record and entry" do
      post = create(:post, user: @user)
      post.create_entry

      delete :destroy, id: post.id

      expect(response).to redirect_to(dashboard_path)
      expect(Post.count).to eq 0
      expect(flash[:notice]).to eq I18n.t(:post_removed)
      expect(Entry.count).to eq 0
    end
  end
end
