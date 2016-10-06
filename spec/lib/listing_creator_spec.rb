require "rails_helper"

describe ListingCreator do
  before do
    create :user, id: 1
    Sidekiq::Worker.clear_all
  end

  describe "#init" do
    it "creates post" do
      post = HashWithIndifferentAccess.new(
        date: Time.zone.now,
        text: "Ищу работу. На кэщ. Манхэттен или Бруклин.",
        vk: "https://vk.com/id325677385",
        fb: "",
        attachments: []
      )
      group = {
        id: 20_420,
        topic: 3_757_285,
        model: "Job",
        state_id: 32,
        city_id: 17_880
      }

      ListingCreator.new(post, group, 1).create

      expect(Job.count).to eq 1
      job = Job.first
      expect(job.text).to eq "Ищу работу. На кэщ. Манхэттен или Бруклин."
      expect(job.vk).to eq "https://vk.com/id325677385"
      expect(job.state_id).to eq 32
      expect(job.city_id).to eq 17_880
      expect(job.title).to_not eq nil

      expect(GeocodeJob.jobs.size).to eq 1
      expect(SlackNotifierJob.jobs.size).to eq 1
      expect(SocialUserNotifierJob.jobs.size).to eq 1
      expect(ImageDownloaderJob.jobs.size).to eq 0
      expect(Entry.count).to eq 1
    end

    context "attachments" do
      it "creates re_private with attachments" do
        rp = HashWithIndifferentAccess.new(
          date: Time.zone.now,
          text: "Ищу работу. На кэщ. Манхэттен или Бруклин.",
          text: "Post long text",
          vk: "https://vk.com/id325677385",
          fb: "",
          attachments: ["foo.com/image"]
        )
        group = {
          id: 20_420,
          topic: 3_757_285,
          model: "RePrivate",
          state_id: 32,
          city_id: 17_880
        }

        ListingCreator.new(rp, group, 1).create

        expect(RePrivate.count).to eq 1
        rp = RePrivate.first
        expect(rp.text).to eq "Post long text"
        expect(rp.vk).to eq "https://vk.com/id325677385"
        expect(rp.state_id).to eq 32
        expect(rp.city_id).to eq 17_880

        expect(GeocodeJob.jobs.size).to eq 1
        expect(SlackNotifierJob.jobs.size).to eq 1
        expect(SocialUserNotifierJob.jobs.size).to eq 1
        expect(ImageDownloaderJob.jobs.size).to eq 1
        expect(Entry.count).to eq 1
      end
    end

    context "sale" do
      it "creates sale" do
        sale = HashWithIndifferentAccess.new(
          date: Time.zone.now,
          text: "Post long text",
          vk: "https://vk.com/id325677385",
          fb: "",
          attachments: ["foo.com/image"]
        )
        group = {
          id: 20_420,
          topic: 3_757_285,
          model: "Sale",
          state_id: 32,
          city_id: 17_880
        }

        ListingCreator.new(sale, group, 1).create

        expect(Sale.count).to eq 1
        rp = Sale.first
        expect(rp.text).to eq "Post long text"
        expect(rp.vk).to eq "https://vk.com/id325677385"
        expect(rp.state_id).to eq 32
        expect(rp.city_id).to eq 17_880

        expect(GeocodeJob.jobs.size).to eq 1
        expect(SlackNotifierJob.jobs.size).to eq 1
        expect(SocialUserNotifierJob.jobs.size).to eq 1
        expect(ImageDownloaderJob.jobs.size).to eq 1
        expect(Entry.count).to eq 1
      end
    end
  end
end
