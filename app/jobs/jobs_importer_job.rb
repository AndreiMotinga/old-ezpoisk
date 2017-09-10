# frozen_string_literal: true

# imports jobs from sm
class JobsImporterJob
  include Sidekiq::Worker
  sidekiq_options queue: "critical"

  def perform
    return unless Rails.env.production?
    Media::Importer.import("public/groups/vk/jobs.yaml", Vk::GroupLoader)
    Media::Importer.import("public/groups/fb/jobs.yaml", Fb::GroupLoader)

    Listing.where("created_at > ?", 130.minutes.ago).find_each do |l|
      user = User.find_by_name(l.user.name)
      Listing.where(from_name: user.name).update_all(user_id: user.id) if user
    end
    Ez.ping("Jobs import done")
  end
end

Sidekiq::Cron::Job.create(name: "JobsImporterJob - every 2 hours on 5th min",
                          cron: "5 */2 * * *",
                          class: "JobsImporterJob")
