require "rails_helper"

describe Media::Creator do
  before do
    create :user, id: 1
    Sidekiq::Worker.clear_all
  end

  describe "#init" do
    it "creates item" do
      item = {
        date: Time.zone.now,
        text: "Ищу работу. На кэщ. Манхэттен или Бруклин.",
        vk: "https://vk.com/id325677385",
        fb: "",
        attachments: [],
        model: "Job",
        state_id: 32,
        city_id: 17_880
      }

      Media::Creator.new(item).create

      expect(Job.count).to eq 1
      job = Job.first
      expect(job.text).to eq "Ищу работу. На кэщ. Манхэттен или Бруклин."
      expect(job.vk).to eq "https://vk.com/id325677385"
      expect(job.state_id).to eq 32
      expect(job.city_id).to eq 17_880
      expect(job.title).to_not eq nil

      expect(SlackNotifierJob.jobs.size).to eq 1
      expect(SocialUserNotifierJob.jobs.size).to eq 1
      expect(ImageDownloaderJob.jobs.size).to eq 0
      expect(Entry.count).to eq 1
    end

    context "attachments" do
      it "creates re_private with attachments" do
        rp = {
          date: Time.zone.now,
          text: "item long text",
          vk: "https://vk.com/id325677385",
          fb: "",
          attachments: ["foo.com/image"],
          model: "RePrivate",
          state_id: 32,
          city_id: 17_880
        }

        Media::Creator.new(rp).create

        expect(RePrivate.count).to eq 1
        rp = RePrivate.first
        expect(rp.text).to eq "item long text"
        expect(rp.vk).to eq "https://vk.com/id325677385"
        expect(rp.state_id).to eq 32
        expect(rp.city_id).to eq 17_880

        expect(SlackNotifierJob.jobs.size).to eq 1
        expect(SocialUserNotifierJob.jobs.size).to eq 1
        expect(ImageDownloaderJob.jobs.size).to eq 1
        expect(Entry.count).to eq 1
      end
    end

    context "sale" do
      it "creates sale" do
        sale = {
          date: Time.zone.now,
          text: "item long text",
          vk: "https://vk.com/id325677385",
          fb: "",
          attachments: ["foo.com/image"],
          model: "Sale",
          state_id: 32,
          city_id: 17_880
        }

        Media::Creator.new(sale).create

        expect(Sale.count).to eq 1
        rp = Sale.first
        expect(rp.text).to eq "item long text"
        expect(rp.vk).to eq "https://vk.com/id325677385"
        expect(rp.state_id).to eq 32
        expect(rp.city_id).to eq 17_880

        expect(SlackNotifierJob.jobs.size).to eq 1
        expect(SocialUserNotifierJob.jobs.size).to eq 1
        expect(ImageDownloaderJob.jobs.size).to eq 1
        expect(Entry.count).to eq 1
      end
    end
  end
end
