source "https://rubygems.org"

ruby "2.3.0"
gem "rails", "~> 5.0"
gem "pg"
gem "sass-rails"
gem "uglifier"
gem "coffee-rails"
gem "jquery-rails"
gem "jquery-ui-rails" #todo remove? how? what does it do?
gem "bootstrap-sass"
gem "select2-rails"
gem 'turbolinks', '~> 5.0.1'

gem "devise"
gem "devise-i18n-views"
gem "devise-i18n"
gem "devise-async", github: "mhfs/devise-async", branch: "devise-4.x"

gem "bootstrap_form"
gem "kaminari"
gem "font-awesome-rails"
gem "paperclip"
gem "dropzonejs-rails"
gem "figaro"
gem "aws-sdk"

gem "slim-rails"

gem "sidekiq"
gem "sidekiq-cron"
gem "sinatra", require: nil, github: "sinatra/sinatra"
gem "rack-protection", github: "sinatra/rack-protection"

gem "geokit-rails", github: "geokit/geokit-rails", branch: "rails5-test"
gem "gmaps4rails"
gem "underscore-rails"
gem "summernote-rails"

# rails admin
gem "rails_admin", github: "sferik/rails_admin"
gem "rack-pjax", github: "afcapel/rack-pjax"
gem "remotipart", github: "mshibuya/remotipart"

gem "rails_admin_tag_list"

gem "sitemap_generator"
gem "slack-notifier"

gem "acts_as_votable"
gem "acts-as-taggable-on", github: "mbleigh/acts-as-taggable-on"

gem "rack-mini-profiler", require: false
gem "rack-cors", require: "rack/cors"

gem "omniauth-facebook"
gem "omniauth-google-oauth2"
gem "omniauth-vkontakte"

gem "friendly_id", github: "norman/friendly_id", branch: "master"
gem "babosa" # handle russian

gem "stripe-rails"

group :production do
  gem "puma"
  gem "rails_12factor"
  # gem 'heroku-deflater'
end

group :development, :test do
#   gem "thin"
  gem "pry-byebug"
  gem "factory_girl_rails"
  gem "faker"
  gem "awesome_print"
end

group :development do
  gem "thin"
  gem "bullet"
  gem "better_errors"
  gem "meta_request"
  gem "spring-commands-rspec"
  gem "spring"
  gem "launchy-rails"

  # code quality
  gem "brakeman", :require => false # security vulnerabilities
  gem "rails_best_practices", :require => false
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
