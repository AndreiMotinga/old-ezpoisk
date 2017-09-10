# frozen_string_literal: true

# imports misc from sm
class MiscImporterJob
  include Sidekiq::Worker
  sidekiq_options queue: "critical"

  def perform
    return unless Rails.env.production?
    Media::Importer.import("public/groups/vk/misc.yaml", Vk::GroupLoader)
    Media::Importer.import("public/groups/fb/misc.yaml", Fb::GroupLoader)

    Listing.where("created_at > ?", 130.minutes.ago).find_each do |l|
      user = User.find_by_name(l.user.name)
      Listing.where(from_name: user.name).update_all(user_id: user.id) if user
    end
    Ez.ping("Misc import done")
  end
end

Sidekiq::Cron::Job.create(name: "MiscImporterJob - every 2 hours on 10th min",
                          cron: "10 */2 * * *",
                          class: "MiscImporterJob")
