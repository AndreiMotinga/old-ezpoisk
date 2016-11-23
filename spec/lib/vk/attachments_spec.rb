require "rails_helper"

describe Vk::Attachments do
  it "returns array of image urls" do
    atts = [
      HashWithIndifferentAccess.new(
        "type" => "photo",
        "photo" => {
          "photo_75" => "small",
          "photo_130" => "medium",
          "photo_604" => "large",
          "width" => 810
        }
      ),
      HashWithIndifferentAccess.new(
        "type" => "photo",
        "photo" => {
          "photo_75" => "small_1",
          "photo_130" => "medium_1",
          "photo_1280" => "large_1",
          "width" => 810
        }
      )
    ]

    result = Vk::Attachments.new(atts).attachments
    expect(result).to eq %w(large large_1)
  end
end
