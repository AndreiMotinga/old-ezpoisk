Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  config.action_controller.perform_caching = true
  config.cache_store = :redis_store, ENV["REDISCLOUD_URL"]

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }

  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    domain: "gmail.com",
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: ENV["GMAIL_USERNAME"],
    password: ENV["GMAIL_PASSWORD"]
  }

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = false

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  # config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  config.paperclip_defaults = {
    storage: :s3,
    s3_protocol: :https,
    s3_region: ENV["AWS_REGION"],
    s3_credentials: {
      bucket: ENV["S3_BUCKET_NAME"],
      access_key_id: ENV["AWS_ACCESS_KEY_ID"],
      secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
    },
    default_url: "https://s3.amazonaws.com/ezpoisk/missing-small.png"
  }

  config.after_initialize do
    Bullet.enable = true
    Bullet.console = true
    Bullet.alert = true
  end
end
