source "https://rubygems.org"

ruby "2.3.0"
gem "rails", "~> 5.0"
gem "pg"
gem "sass-rails"
gem "uglifier"
gem "coffee-rails"
gem "jquery-rails"
gem "jquery-ui-rails"
gem "bootstrap-sass"
gem "select2-rails"
gem "turbolinks", "~> 5.0.1"
gem "summernote-rails"

gem "recipient_interceptor"

gem "autoprefixer-rails"
gem "flutie"

gem "pg_search"

gem "redis-rails"

gem "gretel"

gem "koala", "~> 2.2"
gem "vkontakte_api", '~> 1.4'

gem "devise"
gem "devise-i18n-views"
gem "devise-i18n"
gem "devise-async", github: "mhfs/devise-async", branch: "devise-4.x"
gem "devise_lastseenable"

gem "bootstrap_form"
gem "kaminari", "~> 0.17.0"
gem "font-awesome-rails"
gem "paperclip"
gem "dropzonejs-rails"
gem "aws-sdk"

gem "slim-rails"

gem "sidekiq"
gem "sidekiq-cron"
gem "sinatra", require: nil, github: "sinatra/sinatra"

gem "geokit-rails", github: "geokit/geokit-rails", branch: "rails5-test"
gem "gmaps4rails"
gem "underscore-rails"

# rails admin
gem "rails_admin", github: "sferik/rails_admin"
gem "rack-pjax", github: "afcapel/rack-pjax"
gem "remotipart", github: "mshibuya/remotipart"

gem "rails_admin_tag_list"

gem "sitemap_generator"
gem "slack-notifier"

gem "acts_as_votable"
gem "acts-as-taggable-on", github: "mbleigh/acts-as-taggable-on"

gem "rack-mini-profiler", github: "MiniProfiler/rack-mini-profiler", branch: "master"
gem "memory_profiler"
gem "rack-cors", require: "rack/cors"

gem "omniauth-facebook"
gem "omniauth-google-oauth2"
gem "omniauth-vkontakte"

gem "friendly_id", github: "norman/friendly_id", branch: "master"
gem "babosa" # handle russian

gem "stripe-rails"

gem "rails-timeago", "~> 2.0"

group :production do
  gem "puma"
  gem "rails_12factor"
  # gem 'heroku-deflater'
end

group :development, :test do
  gem "thin"
  gem "pry-byebug"
  gem "awesome_print"
  gem "factory_girl_rails"
  gem "faker"
  gem "dotenv-rails"
end

group :development do
  gem "listen"
  gem "bullet"
  gem "better_errors"
  gem "meta_request"
  gem "spring-commands-rspec"
  gem "spring"
  gem "launchy-rails"
  gem "web-console"

  # code quality
  gem "rails_best_practices", require: false
  gem "brakeman", require: false # security vulnerabilities
  gem "traceroute", require: false # find unused routes
end

group :test do
  gem "fuubar"
  gem "rspec-rails"
  gem "rails-controller-testing"
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
