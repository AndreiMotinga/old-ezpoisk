require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ezpoisk
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.action_view.prefix_partial_path_with_controller_namespace = false

    config.action_mailer.preview_path = "#{Rails.root}/lib/mailer_previews"
    config.action_mailer.default_url_options = { host: "ezpoisk.com" }

    config.eager_load_paths += %W(#{config.root}/app/jobs #{Rails.root}/lib)

    config.middleware.insert_before(Rack::Sendfile, Rack::Deflater)
    config.middleware.insert_before 0, "Rack::Cors" do
      allow do
        origins '*'

        resource '/cors',
          :headers => :any,
          :methods => [:post],
          :credentials => true,
          :max_age => 0

        resource '*',
          :headers => :any,
          :methods => [:get, :post, :delete, :put, :patch, :options, :head],
          :max_age => 0
      end
    end

    config.middleware.insert_before 0, "SearchSuggestions"
  end
end
