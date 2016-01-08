require "rails_helper"

describe CommentsController do
  describe "POST #create" do
    context "user is logged in" do
      it "creates comment and sets current_user as post.user" do
        sign_in(@user = create(:user))
        news_post = create :post
        attrs = attributes_for(:comment)

        post :create, comment: attrs, post_id: news_post.id
        comment = Comment.last

        expect(Comment.count).to eq 1
        expect(comment.body).to eq attrs[:body]
        expect(comment.user).to eq @user
      end
    end

    context "user is not logged in" do
      it "creates comment" do
        news_post = create :post
        attrs = attributes_for(:comment)

        post :create, comment: attrs, post_id: news_post.id
        comment = Comment.last

        expect(Comment.count).to eq 1
        expect(comment.body).to eq attrs[:body]
        expect(comment.user).to be nil
      end
    end
  end
end
