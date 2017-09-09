# frozen_string_literal: true

# imports meetup, parcel & news from sm
class MeetupImporterJob
  include Sidekiq::Worker
  sidekiq_options queue: "critical"

  def perform
    return unless Rails.env.production?
    Media::Importer.import("public/groups/vk/meetup.yaml", Vk::GroupLoader)
    Media::Importer.import("public/groups/vk/parcel.yaml", Vk::GroupLoader)

    Media::Importer.import("public/groups/fb/news.yaml", Fb::GroupLoader)

    Listing.where("created_at > ?", 61.minutes.ago).find_each do |l|
      user = User.find_by_name(l.user.name)
      Listing.where(from_name: user.name).update_all(user_id: user.id) if user
    end
    Ez.ping("Meetup & Parcel & News import done")
  end
end

Sidekiq::Cron::Job.create(name: "MeetupImporterJob - every 1 hours on 15th min",
                          cron: "15 */1 * * *",
                          class: "MeetupImporterJob")
