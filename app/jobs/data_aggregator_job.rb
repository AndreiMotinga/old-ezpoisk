class DataAggregatorJob
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence do
    hourly(12)
  end

  def perform
    return unless Rails.env.production?
    Ez.ping(DataAggregator.new.message)
  end
end
