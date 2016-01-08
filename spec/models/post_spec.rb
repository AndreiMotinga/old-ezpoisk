require "rails_helper"

describe Post, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should validate_presence_of :category }

  it { should belong_to(:user) }

  it { should have_many(:comments).dependent(:destroy) }

  it "posts are ordered by most recent" do
    create :post,
           title: "old post",
           created_at: Date.current - 1.day
    create :post,
           title: "new post",
           created_at: Date.current
    posts = Post.pluck(:title)

    expect(posts).to eq ["new post", "old post"]
  end
end
