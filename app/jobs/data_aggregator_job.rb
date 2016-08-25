class DataAggregatorJob
  include Sidekiq::Worker

  def perform
    Ez.ping(DataAggregator.new.message)
  end
end

Sidekiq::Cron::Job.create(name: "every 4 hours",
                          cron: "0 */4 * * *",
                          class: "DataAggregatorJob")
