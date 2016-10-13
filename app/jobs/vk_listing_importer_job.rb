# imports records from vk
class VkListingImporterJob
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'

  def perform
    VkListingImporter.import
  end
end

Sidekiq::Cron::Job.create(name: "VkListingImporterJob - every 1 hours",
                          cron: "0 */1 * * *",
                          class: "VkListingImporterJob")
