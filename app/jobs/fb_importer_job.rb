# imports records from fb
class FbImporterJob
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'

  def perform
    Media::Importer.new("public/fb_groups.json", Fb::GroupLoader).import
  end
end

Sidekiq::Cron::Job.create(name: "FbImporterJob - every 1 hour (on 30th min)",
                          cron: "30 */1 * * *",
                          class: "FbImporterJob")
