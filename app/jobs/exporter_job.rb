# frozen_string_literal: true

# exports records to vk
class ImporterJob
  include Sidekiq::Worker
  sidekiq_options queue: "critical"

  def perform
    # return unless Rails.env.production?
    Post.for_export.find_each { |p| Vk::Exporter.export(p) }
    Answer.for_export.find_each { |p| Vk::Exporter.export(p) }
    # Listing.for_vk_export.find_each { |p| Vk::Exporter.export(p) }

    Ez.ping("Export done")
  end
end

Sidekiq::Cron::Job.create(name: "ExporterJob - every 2 hours",
                          cron: "59 */2 * * *",
                          class: "ExporterJob")
