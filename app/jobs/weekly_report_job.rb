class WeeklyReportJob
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence do
    weekly.day(:friday).hour_of_day(9)
  end

  def perform
    return unless Rails.env.production?
    Ez.ping(WeeklyReport.new.message)
  end
end
