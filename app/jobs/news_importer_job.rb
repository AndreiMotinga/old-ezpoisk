class NewsImporterJob
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence do
    daily.hour_of_day([0, 12])
  end

  def perform
    return if Rails.env.development?
    NewsImporter.new.import
  end
end
