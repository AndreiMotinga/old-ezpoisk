# frozen_string_literal: true

# imports real estate from sm
class ReImporterJob
  include Sidekiq::Worker
  sidekiq_options queue: "critical"

  def perform
    return unless Rails.env.production?
    Media::Importer.import("public/groups/vk/re.yaml", Vk::GroupLoader)
    Media::Importer.import("public/groups/fb/re.yaml", Fb::GroupLoader)

    Listing.where("created_at > ?", 130.minutes.ago).find_each do |l|
      user = User.find_by_name(l.user.name)
      Listing.where(from_name: user.name).update_all(user_id: user.id) if user
    end
    Ez.ping("Real estate import done")
  end
end

Sidekiq::Cron::Job.create(name: "ReImporterJob - every 2 hours",
                          cron: "0 */2 * * *",
                          class: "ReImporterJob")
