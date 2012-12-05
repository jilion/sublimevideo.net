source 'https://rubygems.org'
source 'https://gems.gemfury.com/8dezqz7z7HWea9vtaFwg' # thibaud@jilion.com account

ruby '1.9.3'

gem 'rails',                '3.2.9'
gem 'sublime_video_layout', '~> 2.0' # hosted on gemfury

# Databases
gem 'pg'

# Views
gem 'haml'
gem 'RedCloth'
gem 'turbolinks' #, github: 'rails/turbolinks'
gem 'google-analytics-turbolinks'

# Internals
gem 'airbrake'
gem 'twitter'
gem 'rack-no-www'
gem 'ratom', require: 'atom'
gem 'rescue_me'
gem 'carrierwave', require: ['carrierwave', 'carrierwave/processing/mime_types']
gem 'countries'
gem 'librato-rails'
gem 'lograge'

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
  gem 'rack-ssl-enforcer'
  gem 'newrelic_rpm'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'rack-livereload', github: 'johnbintz/rack-livereload', branch: 'turbolinks_fix'
  gem 'quiet_assets'
end

group :test do
  gem 'shoulda-matchers'
  gem 'capybara', '~> 1.1.4'
  gem 'poltergeist'

  gem 'webmock', '~> 1.6.0'
  gem 'typhoeus', '~> 0.2.0'
  gem 'vcr', '~> 1.10.3'
  gem 'factory_girl'
  gem 'factory_girl_rails' # loaded in spec_helper Spork.each_run
end

group :tools do
  gem 'powder'

  # Guard
  gem 'ruby_gntp'
  gem 'rb-fsevent'
  gem 'rb-readline'

  gem 'guard-pow'
  gem 'guard-livereload'
  gem 'guard-rspec'
end
