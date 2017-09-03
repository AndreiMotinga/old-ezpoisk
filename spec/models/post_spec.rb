require "rails_helper"

RSpec.describe Post, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:title) }

  describe "#related_posts" do
    it "returns posts with same tags" do
      post = create :post, tag_list: ["работа", "недвижимость"]
      related = create :post, tag_list: ["работа"], created_at: 1.hour.ago
      create :post, tag_list: ["dummy"], created_at: 1.hour.ago

      result = post.related_posts(2).pluck :id

      expect(result).to match [related.id]
    end

    it "returns posts with offset" do
      post = create :post, tag_list: ["работа", "недвижимость"]
      create :post, tag_list: ["работа"], created_at: 1.hour.ago
      related = create :post, tag_list: ["работа"], created_at: 1.day.ago

      result = post.related_posts(2, 1).pluck :id

      expect(result).to match [related.id]
    end

    it "returns posts older than current" do
      post = create :post, tag_list: ["работа", "недвижимость"], created_at: 1.hour.ago
      create :post, tag_list: ["работа"]
      related = create :post, tag_list: ["работа"], created_at: 1.day.ago

      result = post.related_posts(2).pluck :id

      expect(result).to match [related.id]
    end
  end

  describe "#related_answers" do
    it "retursn answers with same tags" do
      post = create :post, tag_list: ["работа", "недвижимость"]
      related = create :answer, tag_list: ["работа"]
      create :answer

      result = post.related_answers(2).pluck :id

      expect(result).to match [related.id]
    end
  end

  describe "#listing?" do
    it "returns false" do
      answer = build :answer
      expect(answer.listing?).to be_falsy
    end
  end

  describe "#article?" do
    it "returns false" do
      answer = build :answer
      expect(answer.article?).to be true
    end
  end

  describe "#city_slug" do
    context "tag is new-york" do
      it "returns new-york" do
        record = build :post, tag_list: "new-york"
        expect(record.city_slug).to eq "new-york"
      end
    end

    context "tag is brooklyn" do
      it "returns new-york" do
        record = build :post, tag_list: "new-york"
        expect(record.city_slug).to eq "new-york"
      end
    end

    context "tag is texas & houston" do
      it "returns houston" do
        record = build :post, tag_list: ["texas", "houston"]
        expect(record.city_slug).to eq "houston"
      end
    end
  end

  # PRIVATE

  it "private updates logo before save" do
    post = build :post, text: "Foo <img src='some_url'/>Bar"

    post.save
    post.reload

    expect(post.logo_url).to eq "some_url"
  end
end
