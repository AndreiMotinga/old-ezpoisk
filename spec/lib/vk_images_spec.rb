require "rails_helper"

describe VkImages do
  describe "#init" do
    it "returnd array of largest images" do
      attachments = [
        { "type": "video", "photo": { "src_xxxbig": "image_url" } },
        { "type": "photo", "photo": { "src_xxxbig": "image_xxx_url" } },
        { "type": "photo", "photo": { "src_xxbig": "image_xx_url" } },
        { "type": "photo", "photo": { "src_xbig": "image_x_url" } },
        { "type": "photo", "photo": { "src": "foo" } },
      ]

      result = VkImages.new(attachments).images

      expect(result).to eq %w(image_xxx_url image_xx_url image_x_url)
    end
  end
end
