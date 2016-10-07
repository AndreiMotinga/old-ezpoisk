class ServiceMixerJob
  include Sidekiq::Worker

  def perform
    # todo fix it
    # Service.random.each {|s| s.update_attribute(:created_at, Time.zone.now) }
  end
end

# Sidekiq::Cron::Job.create(name: "every 3 hours",
#                           cron: "0 */3 * * *",
#                           class: "ServiceMixerJob")
