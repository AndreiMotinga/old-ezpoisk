source "https://rubygems.org"

ruby "2.2.1"
gem "rails", "4.2.5"
gem "pg", "~> 0.15"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.1.0"
gem "jquery-rails"
gem "bootstrap-sass"

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

gem "sidekiq"
gem "sinatra", require: nil
gem "sidetiq"

gem "geokit-rails", github: "geokit/geokit-rails"
gem "gmaps4rails"
gem "underscore-rails"

gem "summernote-rails"

gem "rails_admin"
gem "bootstrap-wysihtml5-rails"

gem "rails_12factor", group: :production
gem "puma"

gem "forem", github: "radar/forem", branch: "rails4"
gem "forem-bootstrap", github: "radar/forem-bootstrap"

gem "sitemap_generator"
gem "slack-notifier"

group :development, :test do
  gem "pry-byebug"
  gem "factory_girl_rails"
  gem "faker"
  gem "awesome_print"
  gem "guard-livereload", "~> 2.4", require: false
  gem "web-console"
end

group :development do
  gem "quiet_assets"
  gem "bullet"
  gem "better_errors"
  gem "meta_request"
  gem "spring-commands-rspec"
  gem "spring"
  gem "guard-rspec", require: false
  gem "terminal-notifier-guard"
  gem "launchy-rails"
end

group :test do
  gem "rspec-rails"
  gem "webmock" # stub external connections
  gem "capybara"
  gem "capybara-webkit"
  gem "shoulda-matchers"
  gem "database_cleaner"
end
