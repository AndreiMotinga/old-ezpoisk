require "rails_helper"

describe Comment do
  it { should belong_to(:commentable) }
  it { should validate_presence_of :text }
  it { should validate_presence_of :user_id }

  describe "#subscribers" do
    context "comment is first" do
      it "returns commentable author" do
        rp = create :listing
        comment = create :comment, commentable: rp

        expect(comment.subscribers).to match [rp.user]
      end
    end

    context "comment is a response" do
      it "returns commentable author and parent comment's author" do
        rp = create :listing
        comment = create :comment, commentable: rp
        response = create :comment, commentable: rp, parent_id: comment.id

        expect(response.subscribers.size).to eq 2
        expect(response.subscribers).to match [rp.user, comment.user]
      end
    end

    describe "#emails" do
      it "returns users who should be notified" do
        offline = create :user, last_seen: 1.day.ago
        rp = create :listing, user: offline
        online = create :user, last_seen: 1.minute.ago
        create :comment
        comment = create :comment, commentable: rp, user: online
        response = create :comment, commentable: rp, parent_id: comment.id

        expect(response.emails).to match [offline.email]
      end
    end
  end
end
