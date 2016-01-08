require "rails_helper"

describe Comment, type: :model do
  it { should validate_presence_of :body }
  it { should validate_presence_of :post_id }
  it { should belong_to(:user) }
  it { should belong_to(:post) }

  it "comments are ordered by most recent" do
    create :comment,
           body: "old comment",
           created_at: Date.current - 1.day
    create :comment,
           body: "new comment",
           created_at: Date.current
    comments = Comment.pluck(:body)

    expect(comments).to eq ["new comment", "old comment"]
  end
end
