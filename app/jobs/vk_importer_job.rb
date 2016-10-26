# imports records from vk
class VkImporterJob
  include Sidekiq::Worker
  sidekiq_options queue: "critical"

  def perform
    MediaImporterJob.perform_async("public/vk_groups.json", Vk::GroupLoader)
  end
end

Sidekiq::Cron::Job.create(name: "VkImporterJob - every 1 hours",
                          cron: "0 */1 * * *",
                          class: "VkImporterJob")
