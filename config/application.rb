require_relative 'boot'
require_relative '../app/middleware/search_suggestions'
require 'rails/all'
Bundler.require(*Rails.groups)
module Ezpoisk
  class Application < Rails::Application
    config.assets.quiet = true
    config.action_controller.action_on_unpermitted_parameters = :raise
    config.eager_load_paths += %W(#{config.root}/app/jobs #{Rails.root}/lib)
    config.generators do |generate|
      generate.helper false
      generate.javascript_engine false
      generate.request_specs false
      generate.routing_specs false
      generate.controller_specs false
      generate.stylesheets false
      generate.test_framework :rspec
      generate.view_specs false
    end

    config.i18n.load_path += Dir[Rails.root.join("config", "locales",
                                                 "**/*", "*.{rb,yml}")]

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins "*"
        resource "*", headers: :any, methods: [:get, :post, :options]
      end
    end

    config.middleware.insert_before 0, SearchSuggestions
  end
end
