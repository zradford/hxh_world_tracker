source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.0"

gem "rails", "~> 7.0.7"
gem "sprockets-rails"

# db needs to be postgres for fly.io
gem "pg"

gem "puma", "~> 5.0"

gem "importmap-rails"

gem "turbo-rails"

# TODO: not sure i need this
gem "stimulus-rails"

gem "jbuilder"

gem "redis", "~> 4.0"

gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

gem "bootsnap", require: false

gem "bulma-rails"

gem "devise", "~> 4.9"


# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "dotenv"
end

group :development do
  gem "pry"
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end



gem "dockerfile-rails", ">= 1.5", :group => :development

gem "sentry-ruby", "~> 5.10"

gem "sentry-rails", "~> 5.10"
