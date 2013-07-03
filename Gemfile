source 'https://rubygems.org'
source 'https://8dezqz7z7HWea9vtaFwg@gem.fury.io/me/' # thibaud@jilion.com account

ruby '2.0.0'

gem 'rails', '~> 4.0.0' # until 3.2.14 is out!
gem 'rails_12factor'
gem 'sublime_video_layout',      '~> 3.0.0.alpha' # hosted on gemfury
# gem 'sublime_video_layout',      path: '~/Code/Jilion/Products/SublimeVideo/sublime_video_layout' # change to your own path
gem 'sublime_video_private_api', '~> 1.0' # hosted on gemfury

# Databases
gem 'pg'
gem 'squeel', github: 'ernie/squeel' # Rails 4 support, until 1.1.0

# Views
gem 'haml'
gem 'haml-contrib'
gem 'slim'
gem 'bourbon'
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
gem 'autoscaler'
gem 'honeybadger'
gem 'twitter'
gem 'zendesk_api'
gem 'ratom', require: 'atom'
gem 'rescue_me'
gem 'carrierwave', require: ['carrierwave', 'carrierwave/processing/mime_types']
gem 'librato-rails', github: 'librato/librato-rails', branch: 'feature/rack_first'
gem 'uniquify'
gem 'oj'
gem 'net-scp', '1.0.4'

gem 'lograge'
gem 'countries'
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
  gem 'dotenv-rails'
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
