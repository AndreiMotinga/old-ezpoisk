require "rails_helper"

describe Vk::Attachments do
  it "returns array of image urls" do
    atts = [
      { "type": "video", "photo": { "src_xxxbig": "image_url" } },
      { "type": "photo", "photo": { "src_xxxbig": "image_xxx_url" } },
      { "type": "photo", "photo": { "src_xxbig": "image_xx_url" } },
      { "type": "photo", "photo": { "src_xbig": "image_x_url" } },
      { "type": "photo", "photo": { "src": "foo" } }
    ]
    result = Vk::Attachments.new(atts).attachments
    expect(result).to eq %w(image_xxx_url image_xx_url image_x_url)
  end
end
