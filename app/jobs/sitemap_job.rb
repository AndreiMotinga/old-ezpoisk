class SitemapJob
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence do
    daily.hour_of_day(2)
  end

  def perform
    system "rake sitemap:create_upload_and_ping"
  end
end
