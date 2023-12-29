source "https://rubygems.org"

ruby "3.2.1"

gem "bootsnap", require: false
gem "importmap-rails"
gem "pg"
gem "puma"
gem "rails"
gem "redis"
gem "sprockets-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[mswin mswin64 mingw x64_mingw jruby]

gem "rails-i18n"

gem "devise"
gem "devise-i18n"
gem "omniauth-google-oauth2"
gem "omniauth-rails_csrf_protection"
gem "pundit"
gem "rolify"

gem "kaminari"
gem "kaminari-i18n"

gem "enumerize"
gem "meta-tags"
gem "simple_form"

gem "sidekiq"

group :development, :test do
  gem "debug", platforms: %i[mri mswin mswin64 mingw x64_mingw]

  gem "annotate", require: false

  gem "erb_lint", require: false
  gem "rubocop", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false

  gem "shoulda-matchers"

  gem "brakeman", require: false
  gem "rails_best_practices", require: false

  gem "bullet"
  gem "factory_bot_rails"
  gem "rspec-rails"
end

group :development do
  gem "error_highlight", platforms: [:ruby]
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"

  gem "faker"
  gem "simplecov", require: false
end
