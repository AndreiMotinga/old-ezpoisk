require "rails_helper"

describe VkCreator do
  before do
    create :user, id: 181
    Sidekiq::Worker.clear_all
  end

  describe "init" do
    it "creates regular post from vk_response" do
      post = HashWithIndifferentAccess.new({
        from_id: 325677385,
        date: 1474560879,
        text: "Ищу работу. На кэщ. Манхэттен или Бруклин."
      })

      VkCreator.new(post, vk_group, 1)

      expect(Job.count).to eq 1
      job = Job.first
      expect(job.text).to eq "Ищу работу. На кэщ. Манхэттен или Бруклин."
      expect(job.vk).to eq "https://vk.com/id325677385"
      expect(job.state_id).to eq 32
      expect(job.city_id).to eq 17_880
      expect(job.title).to_not eq nil

      expect(GeocodeJob.jobs.size).to eq 1
      expect(SlackNotifierJob.jobs.size).to eq 1
      expect(Entry.count).to eq 1
    end
  end

  describe "init" do
    it "creates re_private with attachments from vk_response" do
      rp = HashWithIndifferentAccess.new({
        "from_id"=>216072410,
        "date"=>1474723701,
        "text"=>"Post text",
        "attachments"=>[{"type"=>"photo", "photo"=> { "src_xxxbig"=>"https://pp.vk.me/c633130/v633130138/38c85/NP-b38Wzz4c.jpg" }}]
      })
      stub_request(:get, rp[:attachments][0][:photo][:src_xxxbig])

      VkCreator.new(rp, vk_rp_group, 1)

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
  end
end

def vk_group
  { id: 20_420, topic: 3_757_285, model: "Job", state_id: 32, city_id: 17_880 }
end

def vk_rp_group
  { id: 20_420, topic: 3_757_285, model: "RePrivate", state_id: 32, city_id: 17_880 }
end
