require Rails.root.join("config/smtp")
Rails.application.configure do
  config.middleware.use Rack::CanonicalHost, ENV.fetch("APPLICATION_HOST")
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.public_file_server.enabled = true
  config.assets.js_compressor = :uglifier

  config.assets.compile = false
  config.action_controller.asset_host = ENV.fetch("ASSET_HOST", ENV.fetch("APPLICATION_HOST"))
  config.log_level = :debug
  config.log_tags = [ :request_id ]
  config.action_mailer.perform_caching = false
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = SMTP_SETTINGS
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new
  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end
  config.active_record.dump_schema_after_migration = false
  config.middleware.use Rack::Deflater
  config.public_file_server.headers = {
    "Cache-Control" => "public, max-age=31557600",
  }
  config.action_mailer.default_url_options = { host: ENV.fetch("APPLICATION_HOST") }

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

  config.cache_store = :redis_store, ENV["REDISCLOUD_URL"]
end
Rack::Timeout.timeout = (ENV["RACK_TIMEOUT"] || 10).to_i
