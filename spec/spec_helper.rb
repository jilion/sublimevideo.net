require 'rubygems'

ENV["RAILS_ENV"] ||= 'test'

require File.dirname(__FILE__) + "/../config/environment"
require 'rspec/rails'

require 'capybara/rspec'
require 'capybara/rails'
Capybara.app_host = 'http://sublimevideo.dev'


require 'vcr'
VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
  c.run_all_when_everything_filtered = true
  c.filter_run_including focus: true

  c.mock_with :rspec
end

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
