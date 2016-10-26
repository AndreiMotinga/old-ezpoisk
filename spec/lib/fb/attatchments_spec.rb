require "rails_helper"

describe Fb::Attachments do
  describe "#attachments" do
    it "returns array of images" do
      atts = HashWithIndifferentAccess.new({
        data: [{media: {image: { src: "image_url" }}, type: "photo"}]
      })

      result = Fb::Attachments.new(atts).attachments

      expect(result).to eq %w(image_url)
    end

    it "returns empty array when there are no pictures" do
      atts = HashWithIndifferentAccess.new(
        data: [{}]
      )

      result = Fb::Attachments.new(atts).attachments

      expect(result).to eq []
    end

    it "returns subattachments" do
      atts = HashWithIndifferentAccess.new(
        data: [{
          subattachments: {
            data: [
              { media: { image: { src: "foo" } } },
              { media: { image: { src: "bar" } } }
            ]
          }
        }]
      )

      result = Fb::Attachments.new(atts).attachments

      expect(result).to eq %w(foo bar)
    end
  end
end
