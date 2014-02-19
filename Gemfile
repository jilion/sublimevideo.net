source 'https://rubygems.org'
source 'https://8dezqz7z7HWea9vtaFwg:@gem.fury.io/me/' # thibaud@jilion.com account

ruby '2.0.0'

gem 'rails', '~> 4.0.3'
gem 'i18n'
gem 'sublime_video_layout', '~> 3.1.0' # hosted on gemfury
gem 'sublime_video_private_api', '~> 1.6' # hosted on gemfury

# Databases
gem 'pg'

# Views
gem 'haml'
gem 'haml-contrib'
gem 'slim'
gem 'bourbon', github: 'octave/bourbon', branch: 'ie10-flexbox-2009'
gem 'sass', '~> 3.2.14'
gem 'RedCloth'
gem 'turbolinks', github: 'jilion/turbolinks', branch: 'ios_video_issue'
gem 'google-analytics-turbolinks'
gem 'htmlentities'

# Controllers
gem 'has_scope'
gem 'responders'
gem 'kaminari'

# Internals
gem 'sidekiq'
gem 'honeybadger'
gem 'twitter'
gem 'zendesk_api'
gem 'ratom', require: 'atom'
gem 'rescue_me'
gem 'fog'
gem 'unf'
gem 'carrierwave', require: ['carrierwave', 'carrierwave/processing/mime_types']
gem 'librato-rails', github: 'librato/librato-rails'
gem 'uniquify'
gem 'oj'
gem 'faraday', '~> 0.8.9'

gem 'lograge'
gem 'countries'
gem 'country_select'
gem 'rack-status'

# Gems used only for assets and not required
# in production environments by default.
gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier'

group :production do
  gem 'rack-google-analytics'
end

group :staging, :production do
  gem 'unicorn', require: false
  gem 'memcachier'
  gem 'rack-cache'
  gem 'dalli'
  gem 'kgio'
  gem 'rack-no-www'
  gem 'rack-ssl-enforcer'
  gem 'newrelic_rpm'
  gem 'rails_12factor'
end

group :development, :test do
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'rspec-rails'
  gem 'rack-livereload'
  gem 'ffaker'

  gem 'powder', require: false
  gem 'annotate', require: false

  # Guard
  gem 'ruby_gntp', require: false

  gem 'guard-pow', require: false
  gem 'guard-livereload', require: false
  gem 'guard-rspec', require: false
end

group :test do
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'launchy'
  gem 'codeclimate-test-reporter', require: false

  gem 'vcr'
  gem 'webmock', '~> 1.13'
  gem 'factory_girl_rails'
end
