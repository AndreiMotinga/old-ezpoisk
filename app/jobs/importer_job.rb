# frozen_string_literal: true

# imports records from fb
class ImporterJob
  include Sidekiq::Worker
  sidekiq_options queue: "critical"

  def perform
    return unless Rails.env.production?
    Media::Importer.import("public/vk_groups.json", Vk::GroupLoader)
    Media::Importer.import("public/fb_groups.json", Fb::GroupLoader)
    Listing.where("created_at > ?", 130.minutes.ago).find_each do |l|
      user = User.find_by_name(l.from_name)
      l.update_column(:user_id, user.id) if user && l.user_id != user.id
    end
    Ez.ping("Import done")
  end
end

Sidekiq::Cron::Job.create(name: "ImporterJob - every 2 hours",
                          cron: "0 */2 * * *",
                          class: "ImporterJob")
