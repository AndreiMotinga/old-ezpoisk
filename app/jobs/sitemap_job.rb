# frozen_string_literal: true

class SitemapJob
  include Sidekiq::Worker
  def perform
    return if Rails.env.development?
    system "rake sitemap:create_upload_and_ping"
  end
end

Sidekiq::Cron::Job.create(name: "sitemap job",
                          cron: "0 11 * * *",
                          class: "SitemapJob")
