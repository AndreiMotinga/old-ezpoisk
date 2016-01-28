class HoroscopeImporterJob
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  sidekiq_options queue: :low

  recurrence { daily.hour_of_day(0) }

  def perform
    return if Rails.env.development?
    HoroscopeImporter.new.import
  end
end
