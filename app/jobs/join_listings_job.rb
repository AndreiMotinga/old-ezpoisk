# frozen_string_literal: true

# joins old listings with newly created ones
class JoinListingsJob
  include Sidekiq::Worker
  sidekiq_options queue: "critical"

  def perform
    return unless Rails.env.production?
    Listing.where("created_at > ?", 130.minutes.ago).find_each do |l|
      user = User.find_by_name(l.from_name)
      l.update_column(:user_id, user.id) if user && l.user_id != user.id
    end
    Ez.ping("JoinListingsJob done")
  end
end

Sidekiq::Cron::Job.create(name: "JoinListingsJob - every 2 hours (on 8th min)",
                          cron: "8 */2 * * *",
                          class: "JoinListingsJob")
