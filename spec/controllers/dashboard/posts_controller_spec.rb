require "rails_helper"

describe Dashboard::PostsController do
  before { sign_in(@user = create(:user)) }

  describe "POST #create" do
    it "creates record" do

      attrs = attributes_for(:post)

      post :create, params: { post: attrs }
      article = assigns(:post)

      expect(response).to redirect_to(
        post_path(article)
      )
      expect(article.title).to eq attrs[:title]
      expect(article.user).to eq @user
      expect(article.text).to eq attrs[:text]
      expect(article.category).to eq attrs[:category]
      expect(article.summary).to eq attrs[:summary]

      expect(FbExporterJob.jobs.size).to eq 1
      expect(VkExporterJob.jobs.size).to eq 1
      expect(Entry.count).to eq 1
    end
  end

  describe "DELETE #destroy" do
    it "removes record and entry" do
      post = create(:post, user: @user)
      post.create_entry

      delete :destroy, params: { id: post.id }

      expect(response).to redirect_to(dashboard_posts_path)
      expect(Post.count).to eq 0
      expect(flash[:notice]).to eq I18n.t(:post_removed)
      expect(Entry.count).to eq 0
    end
  end
end
