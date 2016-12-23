# deactivates listings that weren't updated for 30 days.
class ListingsDeactivatorJob
  include Sidekiq::Worker

  def perform
    listings = Listing.to_deactivate
    listings.where(user_id: 1).destroy_all
    listings.update_all(active: false)
  end
end

Sidekiq::Cron::Job.create(name: "ListingsDeactivatorJob - every day",
                          cron: "0 0 * * *",
                          class: "ListingsDeactivatorJob")
