require_relative 'boot'
require 'rails/all'
Bundler.require(*Rails.groups)

module Ezpoisk
  class Application < Rails::Application
    config.action_view.prefix_partial_path_with_controller_namespace = false
    config.eager_load_paths += %W(#{config.root}/app/jobs #{Rails.root}/lib)
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
