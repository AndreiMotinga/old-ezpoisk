# frozen_string_literal: true

# imports records from vk
class VkImporterJob
  include Sidekiq::Worker
  sidekiq_options queue: "critical"

  def perform
    return unless Rails.env.production?
    Media::Importer.import("public/vk_groups.json", Vk::GroupLoader)
    Ez.ping("VkImporterJob done")
  end
end

Sidekiq::Cron::Job.create(name: "VkImporterJob - every 2 hours",
                          cron: "0 */2 * * *",
                          class: "VkImporterJob")
