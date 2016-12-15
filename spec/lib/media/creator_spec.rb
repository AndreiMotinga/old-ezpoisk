require "rails_helper"

describe Media::Creator do
  before { create :user, id: 1 }

  describe "#create" do
    it "creates listing" do
      item = {
        attachments: [],
        attributes: {
          created_at: Time.zone.now,
          text: "Ищу работу. На кэщ. Манхэттен или Бруклин.",
          vk: "https://vk.com/id325677385",
          fb: "",
          state_id: 33,
          city_id: 17_880,
          user_id: 1,
          kind: "job",
          category: "wanted",
          subcategory: "restaurants",
          title: "Dummy title"
        }
      }

      Media::Creator.new(item).create

      listing = Listing.last
      item[:attributes].each do |key, val|
        expect(listing.send(key)).to eq val
      end
      expect(listing.active?).to eq false
      expect(ImageDownloaderJob.jobs.size).to eq 1
    end
  end
end
