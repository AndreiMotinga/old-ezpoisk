class DataAggregatorJob
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence do
    hourly(4)
  end

  def perform
    return unless Rails.env.production?
    Ez.ping(DataAggregator.new.message)
  end
end
