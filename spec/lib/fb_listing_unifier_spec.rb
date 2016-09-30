require "rails_helper"

describe FbListingUnifier do
  describe "#init" do
    it "returns formatted post" do
      post = HashWithIndifferentAccess.new(
        from: { name: "Marianna Sumina", id: "101" },
        message: "У нас на работе есть вакансия",
        created_time: "2016-09-23T21:37:02+0000",
        id: "249106225164786_1151928844882515"
      )

      result = FbListingUnifier.new(post).post

      expect(result[:date]).to eq post[:created_time]
      expect(result[:text]).to eq post[:message]
      expect(result[:vk]).to eq ""
      expect(result[:fb]).to eq "https://www.facebook.com/101"
    end

    context "attachments" do
      it "returns array of images" do
        post = HashWithIndifferentAccess.new(
          from: { name: "Marianna Sumina", id: "101" },
          message: "У нас на работе есть вакансия",
          created_time: "2016-09-23T21:37:02+0000",
          attachments: {
            data: [{media: {image: { src: "image_url" }}, type: "photo"}]
          }
        )

        result = FbListingUnifier.new(post).post

        expect(result[:attachments]).to eq %w(image_url)
      end

      it "returns empty array when there are no pictures" do
        post = HashWithIndifferentAccess.new(
          from: { name: "Marianna Sumina", id: "101" },
          message: "У нас на работе есть вакансия",
          created_time: "2016-09-23T21:37:02+0000",
          attachments: { data: [{}] }
        )

        result = FbListingUnifier.new(post).post

        expect(result[:attachments]).to eq []
      end

      it "returns subattachments" do
        post = HashWithIndifferentAccess.new(
          from: { name: "Marianna Sumina", id: "101" },
          message: "У нас на работе есть вакансия",
          created_time: "2016-09-23T21:37:02+0000",
          attachments: {
            data: [{
              subattachments: {
                data: [
                  { media: { image: { src: "foo" } } },
                  { media: { image: { src: "bar" } } }
                ]
              }
            }]
          }
        )

        result = FbListingUnifier.new(post).post

        expect(result[:attachments]).to eq %w(foo bar)
      end
    end
  end
end
