# imports records from fb
class FbListingImporterJob
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'

  def perform
    FbListingImporter.import
  end
end

Sidekiq::Cron::Job.create(name: "FbListingImporterJob - every 1 hours (on 30th)",
                          cron: "30 */1 * * *",
                          class: "FbListingImporterJob")
