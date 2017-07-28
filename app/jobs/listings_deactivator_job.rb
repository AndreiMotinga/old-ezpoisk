# deactivates listings that weren't updated for 30 days.
# todo - I removed cron schedule form heroku - do I need this?
class ListingsDeactivatorJob
  include Sidekiq::Worker

  def perform
    # user = User.first # ez
    # listings = Listing.to_deactivate
    # listings.where(user_id: user.id).destroy_all
    # listings.update_all(active: false)
  end
end

# Sidekiq::Cron::Job.create(name: "ListingsDeactivatorJob - every day",
#                           cron: "0 0 * * *",
#                           class: "ListingsDeactivatorJob")
