class DataAggregatorJob
  def perform
    # todo make global var. if dev  or test post to tech chanel, esle to ez
    return unless Rails.env.production?
    Ez.ping(DataAggregator.new.message)
  end
end

Sidekiq::Cron::Job.create(name: "every 6 hours",
                          cron: "0 */6 * * *",
                          class: "DataAggregatorJob")
