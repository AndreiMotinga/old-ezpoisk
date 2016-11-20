require_relative 'boot'
require_relative '../app/middleware/search_suggestions'
require 'rails/all'
Bundler.require(*Rails.groups)
module Ezpoisk
  class Application < Rails::Application
    config.assets.quiet = true
    config.action_controller.action_on_unpermitted_parameters = :raise
    # todo before redesign - remove
    config.action_view.prefix_partial_path_with_controller_namespace = false
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

    config.middleware.insert_before 0, Rack::Cors do
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

    config.middleware.insert_before 0, SearchSuggestions
  end
end
