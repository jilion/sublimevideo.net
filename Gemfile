source 'https://rubygems.org'
source 'https://8dezqz7z7HWea9vtaFwg:@gem.fury.io/me/' # thibaud@jilion.com account

ruby '2.0.0'

gem 'rails', '3.2.13'
gem 'sublime_video_layout',      '~> 2.0' # hosted on gemfury
gem 'sublime_video_private_api', '~> 1.0' # hosted on gemfury

# Databases
gem 'pg'
gem 'squeel'

# Views
gem 'haml'
gem 'haml-contrib'
gem 'RedCloth'
gem 'turbolinks', github: 'jilion/turbolinks', branch: 'ios_video_issue'
gem 'google-analytics-turbolinks'

# Controllers
gem 'has_scope'
gem 'responders'
gem 'kaminari'

# Internals
gem 'sidekiq'
gem 'autoscaler'
gem 'honeybadger'
gem 'twitter'
gem 'zendesk_api'
gem 'ratom', require: 'atom'
gem 'rescue_me'
gem 'carrierwave', require: ['carrierwave', 'carrierwave/processing/mime_types']
gem 'librato-rails', github: 'librato/librato-rails', branch: 'feature/rack_first'
gem 'configurator', github: 'jilion/configurator'
gem 'uniquify'
gem 'oj'
gem 'net-scp', '1.0.4'

gem 'lograge'
gem 'countries', github: 'hexorx/countries' # until 0.9.2 is out!
gem 'rack-status'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'asset_sync'
end

group :production do
  gem 'rack-google-analytics'
end

group :staging, :production do
  gem 'unicorn'
  gem 'memcachier'
  gem 'dalli'
  gem 'rack-cache'
  gem 'rack-no-www'
  gem 'rack-ssl-enforcer'
  gem 'newrelic_rpm'
end

group :development, :test do
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'rack-livereload'
  gem 'quiet_assets'
  gem 'ffaker'
end

group :test do
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'launchy'
  gem 'poltergeist'

  gem 'vcr'
  gem 'webmock'
  gem 'factory_girl_rails'
end

group :tools do
  gem 'powder'
  gem 'annotate'

  # Guard
  gem 'ruby_gntp'
  gem 'rb-fsevent'

  gem 'guard-pow'
  gem 'guard-livereload'
  gem 'guard-rspec'
end
