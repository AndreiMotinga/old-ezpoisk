require "rails_helper"

describe SocialUserNotifierJob do
  context "vk" do
    it "enqueues vk notifier job" do
      job = build_stubbed :job, vk: "vk.com/id1212", fb: ""
      allow(Job).to receive(:find_by_id).with(job.id).and_return(job)
      allow(VkUserNotifier).to receive(:new).with(job)

      SocialUserNotifierJob.perform_async(job.id, job.class.to_s)
      SocialUserNotifierJob.drain

      expect(Job).to have_received(:find_by_id).with(job.id)
      expect(VkUserNotifier).to have_received(:new).with(job)
    end
  end

  context "fb" do
    it "enqueues fb notifier job" do
      job = build_stubbed :job, vk: "", fb: "facebook.com/id101"
      allow(Job).to receive(:find_by_id).with(job.id).and_return(job)
      allow(FbUserNotifier).to receive(:new).with(job)

      SocialUserNotifierJob.perform_async(job.id, job.class.to_s)
      SocialUserNotifierJob.drain

      expect(Job).to have_received(:find_by_id).with(job.id)
      expect(FbUserNotifier).to have_received(:new).with(job)
    end
  end
end
