require "rails_helper"

describe Media::Creator do
  describe ".create" do
    it "creates listing" do
      item = {
        attachments: [],
        user: {
          provider: "facebook",
          uid: "1234",
          name: "Andrei Motinga"
        },
        attributes: {
          created_at: Time.zone.now,
          text: "Ищу работу. На кэщ. Манхэттен или Бруклин.",
          vk: "https://vk.com/id325677385",
          fb: "",
          state_id: 32,
          city_id: 17_880,
          kind: "job",
          category: "wanted",
          subcategory: "restaurants",
          title: "Dummy title"
        }
      }

      Media::Creator.create(item)

      listing = Listing.last
      item[:attributes].each do |key, val|
        expect(listing.send(key)).to eq val
      end
      expect(listing.active?).to eq true
      expect(ImageDownloaderJob.jobs.size).to eq 1
    end
  end
end
