require "rails_helper"

describe Post, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should validate_presence_of :category }

  describe "#news" do
    it "returns only news posts" do
      news_post = create :post
      create :post, :real_estate

      expect(Post.news).to eq [news_post]
    end

    it "posts are ordered by most recent" do
      create :post,
             title: "old post",
             created_at: Date.current - 1.day
      create :post,
             title: "new post",
             created_at: Date.current
      posts = Post.news.map(&:title)

      expect(posts).to eq ["new post", "old post"]
    end
  end
end
