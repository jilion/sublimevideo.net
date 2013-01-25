source 'https://rubygems.org'
source 'https://gems.gemfury.com/8dezqz7z7HWea9vtaFwg' # thibaud@jilion.com account

ruby '1.9.3'

gem 'rails',                '3.2.11'
gem 'sublime_video_layout', '~> 2.0' # hosted on gemfury

# Databases
gem 'pg'
gem 'squeel'

# Views
gem 'haml'
gem 'RedCloth'
gem 'turbolinks', github: 'jilion/turbolinks', branch: 'ios_video_issue'
gem 'google-analytics-turbolinks'

# Controllers
gem 'has_scope'
gem 'responders'
gem 'kaminari'

# Internals
gem 'sidekiq'
gem 'autoscaler', github: 'jilion/autoscaler', branch: 'respect_specified_queues'
gem 'airbrake'
gem 'twitter'
gem 'zendesk_api'
gem 'ratom', require: 'atom'
gem 'rescue_me'
gem 'carrierwave', require: ['carrierwave', 'carrierwave/processing/mime_types']
gem 'librato-rails', github: 'librato/librato-rails', branch: 'feature/rack_first'
gem 'uniquify'

gem 'lograge'
gem 'countries'

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
  gem 'thin'
  gem 'dalli'
  gem 'rack-cache'
  gem 'rack-no-www'
  gem 'rack-ssl-enforcer'
  gem 'newrelic_rpm'
end

group :development, :test do
  gem 'rspec-rails', github: 'rspec/rspec-rails'
  gem 'rack-livereload'
  gem 'rack-nocache'
  gem 'quiet_assets'
  gem 'ffaker'
end

group :test do
  gem 'rspec',              github: 'rspec/rspec'
  gem 'rspec-core',         github: 'rspec/rspec-core'
  gem 'rspec-expectations', github: 'rspec/rspec-expectations'
  gem 'rspec-mocks',        github: 'rspec/rspec-mocks'
  gem 'shoulda-matchers',   github: 'thoughtbot/shoulda-matchers'
  gem 'capybara'
  gem 'launchy'
  gem 'poltergeist', github: 'brutuscat/poltergeist'

  gem 'vcr'
  gem 'webmock'
  gem 'typhoeus', '~> 0.5.3'
  gem 'factory_girl_rails'
end

group :tools do
  gem 'powder'
  gem 'annotate'

  # Guard
  gem 'ruby_gntp'
  gem 'rb-fsevent'
  gem 'rb-readline'

  gem 'guard-pow'
  gem 'guard-livereload'
  gem 'guard-rspec'
end
