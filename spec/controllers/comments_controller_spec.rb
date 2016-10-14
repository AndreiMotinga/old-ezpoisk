require "rails_helper"

describe CommentsController do
  describe "POST #create" do
    it "creates record" do
      rp = create :re_private
      attrs = { text: "foo", commentable_id: rp.id,
                             commentable_type: rp.class.name }

      post :create, params: { comment: attrs }

      # expect(response).to redirect_to(
      #   post_path(article)
      # )
      comment = Comment.last
      expect(comment.user).to eq nil
      expect(comment.text).to eq attrs[:text]
    end
  end
end
