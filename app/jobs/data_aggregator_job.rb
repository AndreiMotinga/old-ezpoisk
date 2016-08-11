class DataAggregatorJob
  def perform
    return unless Rails.env.development?
    Ez.ping(DataAggregator.new.message)
  end
end

Sidekiq::Cron::Job.create(name: "every 12 hours",
                          cron: "0 */12 * * *",
                          class: "DataAggregatorJob")
