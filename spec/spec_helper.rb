require 'rubygems'

ENV["RAILS_ENV"] ||= 'test'

require File.dirname(__FILE__) + "/../config/environment"
require 'rspec/rails'

require 'capybara/rspec'
require 'capybara/rails'
require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist
Capybara.server_port = 2999

RSpec.configure do |config|
  config.before do
    if example.metadata[:js]
      # http://docs.tddium.com/troubleshooting/browser-based-integration-tests
      # http://asciicasts.com/episodes/221-subdomains-in-rails-3
      $capybara_domain = 'lvh.me'
      Capybara.default_host = "http://#{$capybara_domain}:#{Capybara.server_port}"
    else
      $capybara_domain = 'sublimevideo.dev'
      Capybara.default_host = "http://#{$capybara_domain}"
    end
    Capybara.reset_sessions!
  end
end

RSpec.configure do |config|
  # FactoryGirl http://railscasts.com/episodes/158-factories-not-fixtures-revised
  config.include FactoryGirl::Syntax::Methods
end

require 'vcr'
VCR.configure do |config|
  config.hook_into :webmock, :typhoeus
  config.cassette_library_dir     = 'spec/cassettes'
  config.ignore_localhost         = true
  config.default_cassette_options = { record: :new_episodes }
  config.configure_rspec_metadata!
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run_including focus: true
  config.mock_with :rspec
end

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
