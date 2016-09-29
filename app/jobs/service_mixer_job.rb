class ServiceMixerJob
  include Sidekiq::Worker

  def perform
    Service.random.each {|s| s.update_column(:updated_at, Time.zone.now) }
  end
end

Sidekiq::Cron::Job.create(name: "every 3 hours",
                          cron: "0 */3 * * *",
                          class: "ServiceMixerJob")
