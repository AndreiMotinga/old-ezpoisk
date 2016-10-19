require "rails_helper"

describe CommentsController do
  describe "POST #create" do
    it "creates record" do
      sign_in(@user = create(:user))
      rp = create :re_private, updated_at: 1.day.ago
      rp.create_entry
      attrs = { text: "foo", commentable_id: rp.id,
                             commentable_type: rp.class.name }

      post :create, params: { comment: attrs }

      expect(response).to render_template("create.js.erb")
      rp.reload
      comment = Comment.last
      expect(comment.user).to eq @user
      expect(comment.text).to eq attrs[:text]
      expect(rp.updated_at).to eq Time.zone.now
      expect(CommentNotifierJob.jobs.size).to eq 1
      expect(TouchEntryJob.jobs.size).to eq 1
    end
  end
end
