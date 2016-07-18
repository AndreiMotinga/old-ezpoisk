source "https://rubygems.org"

ruby "2.3.0"
gem "rails", "4.2.5.1"
gem "pg", "~> 0.15"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.1.0"
gem "jquery-rails"
gem "bootstrap-sass"
gem "select2-rails"

gem "devise"
gem "devise-i18n-views"
gem "devise-i18n"
gem "devise-async"

gem "bootstrap_form"

gem "kaminari"
gem "bootstrap-kaminari-views"

gem "font-awesome-rails"

gem "paperclip"
gem "dropzonejs-rails"

gem "figaro"

gem "aws-sdk", "< 2.0"

gem "haml-rails"
gem "slim-rails"

gem "sidekiq"
gem "sinatra", require: nil
gem "sidetiq", '~> 0.6.3'

gem "geokit-rails", github: "geokit/geokit-rails"
gem "gmaps4rails"
gem "underscore-rails"

gem "summernote-rails"

gem "rails_admin"
gem "rails_admin_tag_list"

gem "sitemap_generator"
gem "slack-notifier"

gem "cancancan"
gem "recaptcha", require: "recaptcha/rails"

gem "acts_as_votable", "~> 0.10.0"

gem "acts-as-taggable-on"

gem "rack-mini-profiler", require: false
gem 'rack-cors', :require => 'rack/cors'

gem "omniauth-facebook"
gem "omniauth-google-oauth2"
gem "omniauth-vkontakte"

gem "friendly_id"
gem "babosa" # handle russian

gem "stripe-rails", "~> 0.3.1"

group :production do
  gem "puma"
  gem "rails_12factor"
  # gem 'heroku-deflater'
end

group :development, :test do
  gem "thin"
  gem "pry-byebug"
  gem "factory_girl_rails", "~> 4.7"
  gem "faker"
  gem "awesome_print"
  gem "guard-livereload", "~> 2.4", require: false
end

group :development do
  gem "quiet_assets"
  gem "bullet"
  gem "better_errors"
  gem "meta_request"
  gem "spring-commands-rspec"
  gem "spring", "~> 1.7.1"
  gem "guard-rspec", require: false
  gem "terminal-notifier-guard"
  gem "launchy-rails"
  gem "web-console"

  # code quality
  gem "brakeman", :require => false # security vulnerabilities
  gem "rails_best_practices", :require => false
end

group :test do
  gem "fuubar"
  gem "rspec-rails"
  gem "webmock"
  gem "stripe-ruby-mock", "~> 2.2.4", require: "stripe_mock"
  gem "capybara"
  gem "capybara-webkit"
  gem "capybara-select2"
  gem "shoulda-matchers"
  gem "database_cleaner"
  gem "simplecov", require: false
  gem "timecop"
end
