# imports records from fb
class FbImporterJob
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'

  def perform
    MediaImporterJob.perform_async("public/fb_groups.json", Fb::GroupLoader)
  end
end

Sidekiq::Cron::Job.create(name: "FbImporterJob - every 1 hours (on 30th)",
                          cron: "30 */1 * * *",
                          class: "FbImporterJob")
