class DataAggregatorJob
  def perform
    Ez.ping(DataAggregator.new.message)
  end
end

Sidekiq::Cron::Job.create(name: "every 6 hours",
                          cron: "0 */6 * * *",
                          class: "DataAggregatorJob")
