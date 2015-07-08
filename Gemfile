source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# Use mysql as the database for Active Record
gem 'mysql2'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
  gem 'rspec-rails'
  gem 'fabrication'
  gem 'capybara'
  gem 'launchy'
  gem 'simplecov'
  gem 'guard-rspec'
  gem 'shoulda-matchers'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
  gem 'fuubar'
end

group :test do
  gem 'vcr'
  gem 'webmock', "1.16"
end

group :test, :darwin do
  gem 'rb-fsevent', :require => false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
group :development do
  gem 'capistrano'
  gem 'rvm-capistrano', require: false
  gem "capistrano-db-tasks", require: false
end

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'omniauth-google-oauth2'
gem 'figaro'

gem 'httparty'
gem 'paperclip'

gem 'whenever'
gem 'delayed_job_active_record'
gem 'daemons'
