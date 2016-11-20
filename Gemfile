source "https://rubygems.org"

ruby "2.3.1"
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
gem "rack-canonical-host"

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

gem "rack-cors", require: "rack/cors"

gem "omniauth-facebook"
gem "omniauth-google-oauth2"
gem "omniauth-vkontakte"

gem "friendly_id", github: "norman/friendly_id", branch: "master"
gem "babosa" # todo remove? handle russian

gem "stripe-rails"
gem "rails-timeago", "~> 2.0"
gem "puma"

group :development do
  gem "listen"
  gem "spring"
  gem "spring-commands-rspec"
  gem "web-console"
end

group :development, :test do
  gem "awesome_print"
  gem "bullet"
  gem "dotenv-rails"
  gem "factory_girl_rails"
  gem "faker"
  gem "pry-byebug"
  gem "rspec-rails", "~> 3.5.0.beta4"
end

group :development, :staging do
  gem "rack-mini-profiler", require: false
end

group :test do
  gem "capybara-webkit"
  gem "database_cleaner"
  gem "fuubar"
  gem "launchy"
  gem "rails-controller-testing"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "stripe-ruby-mock", "~> 2.2.4", require: "stripe_mock"
  gem "timecop"
  gem "webmock"
end

group :staging, :production do
  gem "rack-timeout"
  gem "rails_stdout_logging"
end
