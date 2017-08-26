# frozen_string_literal: true

# imports records from fb
class FbImporterJob
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'

  def perform
    return unless Rails.env.production?
    Media::Importer.import("public/fb_groups.json", Fb::GroupLoader)
  end
end

Sidekiq::Cron::Job.create(name: "FbImporterJob - every 2 hours (on 10th min)",
                          cron: "5 */2 * * *",
                          class: "FbImporterJob")
