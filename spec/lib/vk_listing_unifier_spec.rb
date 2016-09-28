require "rails_helper"

describe VkListingUnifier do
  describe "#init" do
    it "returns formatted post" do
      post = HashWithIndifferentAccess.new(
        "from_id": 216_072_410,
        "date": 1_474_723_701,
        "text": "Post text",
        "attachments": [
          { "type": "photo", "photo": { "src_xxxbig": "foo.com" } }
        ]
      )

      result = VkListingUnifier.new(post).post

      expect(result[:from_id]).to eq post[:from_id]
      expect(result[:date]).to eq Time.at(post[:date])
      expect(result[:text]).to eq post[:text]
      expect(result[:vk]).to eq "https://vk.com/id#{post[:from_id]}"
      expect(result[:fb]).to eq ""
      expect(result[:attachments]).to eq ["foo.com"]
    end

    context "attachments" do
      it "returns array of largest images" do
        post = HashWithIndifferentAccess.new(
          "from_id": 216_072_410,
          "date": 1_474_723_701,
          "text": "Post text",
          "attachments": [
            { "type": "video", "photo": { "src_xxxbig": "image_url" } },
            { "type": "photo", "photo": { "src_xxxbig": "image_xxx_url" } },
            { "type": "photo", "photo": { "src_xxbig": "image_xx_url" } },
            { "type": "photo", "photo": { "src_xbig": "image_x_url" } },
            { "type": "photo", "photo": { "src": "foo" } }
          ]
        )

        result = VkListingUnifier.new(post).post

        expect(result[:attachments])
          .to eq %w(image_xxx_url image_xx_url image_x_url)
      end

      it "doesn't blow up" do
        post = HashWithIndifferentAccess.new(
          "from_id": 216_072_410,
          "date": 1_474_723_701,
          "text": "Post text"
        )

        result = VkListingUnifier.new(post).post

        expect(result[:attachments]).to eq []
      end
    end
  end
end
