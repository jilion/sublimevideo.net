source 'https://rubygems.org'
source 'https://gems.gemfury.com/8dezqz7z7HWea9vtaFwg/' # thibaud@jilion.com account

gem 'rails', '3.2.2'
gem 'sublimevideo_layout' # hosted on gemfury

# Views
gem 'haml'
gem 'RedCloth'

# Internals
gem 'airbrake',  '~> 3.0.5'
gem 'twitter',   '~> 2.1.0'
gem 'rack-no-www'
gem 'ratom', require: 'atom'
gem 'rescue_me', '~> 0.1.1', git: 'git://github.com/rymai/rescue_me.git' # until https://github.com/ashirazi/rescue_me/pull/2 is merged


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.0'
  gem 'coffee-rails', '~> 3.2.0'
  gem 'uglifier'
  gem 'asset_sync'
end

group :production do
  gem 'thin'
  gem 'dalli'
  gem 'rack-google-analytics', '~> 0.9.2', require: 'rack/google-analytics'
end

group :staging, :production do
  gem 'newrelic_rpm'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'rack-livereload'
end

group :test do
  gem 'shoulda-matchers'
  gem 'capybara'

  gem 'vcr'
  gem 'webmock'
end

group :tools do
  gem 'heroku'
  gem 'foreman'
  gem 'powder'
  gem 'pry'

  # Guard
  gem 'growl'
  platforms :ruby do
    gem 'rb-readline'
  end

  gem 'guard-pow'
  gem 'guard-livereload'
  gem 'guard-rspec'
end
