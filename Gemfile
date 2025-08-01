source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 8.0.2'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'propshaft'

# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 2.0'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'solr_wrapper', '~> 4.0'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'

end

gem 'blacklight', '~> 9.0.0.beta6'
gem 'blacklight-marc'
gem 'devise'
gem 'devise-guests', '~> 0.3'
gem 'mysql2', group: :production
gem 'traject'

gem 'honeybadger'

gem 'blacklight-locale_picker'
gem 'rsolr', '>= 1.0'

# pin for beanstalk..
gem 'nio4r', '2.7.4'
gem 'uri', '~> 0.13.0'

gem "thruster", "~> 0.1.14"
gem 'puma'
