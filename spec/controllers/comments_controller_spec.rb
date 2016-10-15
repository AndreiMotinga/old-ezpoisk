require "rails_helper"

describe CommentsController do
  describe "POST #create" do
    it "creates record" do
      rp = create :re_private, updated_at: 1.day.ago
      attrs = { text: "foo", commentable_id: rp.id,
                             commentable_type: rp.class.name }

      post :create, params: { comment: attrs }

      expect(response).to render_template("create.js.erb")
      comment = Comment.last
      expect(comment.user).to eq nil
      expect(comment.text).to eq attrs[:text]
      rp.reload
      expect(rp.updated_at).to eq Time.zone.now
    end
  end
end
