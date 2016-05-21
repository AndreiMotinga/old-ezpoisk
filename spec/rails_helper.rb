# This file is copied to spec/ when you run "rails generate rspec:install"
ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
# Prevent database truncation if the environment is production
if Rails.env.production?
  abort("The Rails environment is running in production mode!")
end
require "rspec/rails"
# Add additional requires below this line. Rails is not loaded until this point!
require "capybara/rails"
require "devise"
require "sidekiq/testing"
require "webmock/rspec"
WebMock.disable_net_connect!(allow_localhost: true)

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migration and applies them before tests are run.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  Capybara.javascript_driver = :webkit
  Capybara::Webkit.configure do |conf|
    conf.block_unknown_urls
  end

  config.include Devise::TestHelpers, type: :controller
  config.include Warden::Test::Helpers
  config.include FactoryGirl::Syntax::Methods
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include Helpers

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation, except: %w(states cities))
    Warden.test_mode!
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation, { except: %w(states cities) }
  end

  config.before(:each) do
    Sidekiq::Worker.clear_all
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
    ActionMailer::Base.deliveries.clear
    Warden.test_reset!
  end
end
