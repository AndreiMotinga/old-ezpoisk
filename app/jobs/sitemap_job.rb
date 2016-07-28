class SitemapJob
  def perform
    return if Rails.env.development?
    system "rake sitemap:create_upload_and_ping"
  end
end

Sidekiq::Cron::Job.create(name: "once a day",
                          cron: "0 0 * * *",
                          class: "SitemapJob")
