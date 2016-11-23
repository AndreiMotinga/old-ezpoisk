# imports records from vk
class VkImporterJob
  include Sidekiq::Worker
  sidekiq_options queue: "critical"

  def perform
    Media::Importer.new("public/vk_groups.json", Vk::GroupLoader).import
  end
end

Sidekiq::Cron::Job.create(name: "VkImporterJob - every hour",
                          cron: "0 */1 * * *",
                          class: "VkImporterJob")
