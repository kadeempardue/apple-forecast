# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.5'

gem 'activeresource'
gem 'bulma-rails', '~> 1.0.0'
gem 'dartsass-rails', '~> 0.5.1'
gem 'dotenv'
gem 'geocoder'
gem 'pg'
gem 'puma'
gem 'rack-attack'
gem 'rack-cors'
gem 'rails', '~> 6.1.7', '>= 6.1.7.7'
gem 'redis'
gem 'redis-store'
gem 'responders'
gem 'sprockets-rails'
gem 'webpacker'

# silence warning: loaded from the standard library,
# but will no longer be part of the default gems starting from Ruby 3.4.0
gem 'base64'
gem 'drb'
gem 'fiddle'
gem 'mutex_m'
gem 'ostruct'

group :development, :test do
  gem 'bootsnap'
  gem 'bullet'
  gem 'faker'
  gem 'letter_opener'
  gem 'pry'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'brakeman', require: false
  gem 'listen'
end

group :test do
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
  gem 'rspec-expectations'
  gem 'rspec-its'
  gem 'rspec_junit_formatter'
  gem 'rspec-rails'
  gem 'shoulda-callback-matchers'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'test-prof'
  gem 'timecop'
  gem 'webmock'
end

platforms :ruby do
  gem 'mini_racer', '0.16.0'
end
