class DataAggregatorJob
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence do
    hourly(4)
  end

  def perform
    return if Rails.env.development?
    Ez.ping(DataAggregator.new.message)
  end
end
