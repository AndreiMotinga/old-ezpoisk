require "rails_helper"

describe ListingCreator do
  before do
    create :user, id: 181
    Sidekiq::Worker.clear_all
  end

  describe "#init" do
    it "creates regular post from vk_response" do
      post = HashWithIndifferentAccess.new(
        from_id: 325_677_385,
        date: 1_474_560_879,
        text: "Ищу работу. На кэщ. Манхэттен или Бруклин."
      )
      group = {
        id: 20_420,
        topic: 3_757_285,
        model: "Job",
        state_id: 32,
        city_id: 17_880
      }

      ListingCreator.new(post, group, 1)

      expect(Job.count).to eq 1
      job = Job.first
      expect(job.text).to eq "Ищу работу. На кэщ. Манхэттен или Бруклин."
      expect(job.vk).to eq "https://vk.com/id325677385"
      expect(job.state_id).to eq 32
      expect(job.city_id).to eq 17_880
      expect(job.title).to_not eq nil

      expect(GeocodeJob.jobs.size).to eq 1
      expect(SlackNotifierJob.jobs.size).to eq 1
      expect(VkImageCreatorJob.jobs.size).to eq 0
      expect(VkUserNotifierJob.jobs.size).to eq 1
      expect(Entry.count).to eq 1
    end

    it "creates re_private with attachments from vk_response" do
      rp = HashWithIndifferentAccess.new(
        "from_id": 216_072_410,
        "date": 1_474_723_701,
        "text": "Post text",
        "attachments": [
          { "type": "photo", "photo": { "src_xxxbig": "image_url" } }
        ]
      )
      group = {
        id: 20_420,
        topic: 3_757_285,
        model: "RePrivate",
        state_id: 32,
        city_id: 17_880
      }
      stub_request(:get, rp[:attachments][0][:photo][:src_xxxbig])

      ListingCreator.new(rp, group, 1)

      expect(RePrivate.count).to eq 1
      rp = RePrivate.first
      expect(rp.text).to eq "Post text"
      expect(rp.vk).to eq "https://vk.com/id216072410"
      expect(rp.state_id).to eq 32
      expect(rp.city_id).to eq 17_880

      expect(GeocodeJob.jobs.size).to eq 1
      expect(SlackNotifierJob.jobs.size).to eq 1
      expect(VkImageCreatorJob.jobs.size).to eq 1
      expect(Entry.count).to eq 1
    end

    it "creates re_private without attachments" do
      rp = HashWithIndifferentAccess.new(
        "from_id": 216_072_410,
        "date": 1_474_723_701,
        "text": "Post text",
      )
      group = {
        id: 20_420,
        topic: 3_757_285,
        model: "RePrivate",
        state_id: 32,
        city_id: 17_880
      }

      ListingCreator.new(rp, group, 1)

      expect(RePrivate.count).to eq 1
    end

    it "creates sale with attachments from vk_response" do
      rp = HashWithIndifferentAccess.new(
        "from_id": 216_072_410,
        "date": 1_474_723_701,
        "text": "Post text",
        "attachments": [
          { "type": "photo", "photo": { "src_xxxbig": "image_url" } }
        ]
      )
      group = {
        id: 20_420,
        topic: 3_757_285,
        model: "Sale",
        state_id: 32,
        city_id: 17_880
      }
      stub_request(:get, rp[:attachments][0][:photo][:src_xxxbig])

      ListingCreator.new(rp, group, 1)

      expect(Sale.count).to eq 1
      rp = Sale.first
      expect(rp.text).to eq "Post text"
      expect(rp.vk).to eq "https://vk.com/id216072410"
      expect(rp.state_id).to eq 32
      expect(rp.city_id).to eq 17_880

      expect(GeocodeJob.jobs.size).to eq 1
      expect(SlackNotifierJob.jobs.size).to eq 1
      expect(VkImageCreatorJob.jobs.size).to eq 1
      expect(Entry.count).to eq 1
    end
  end
end
