begin
  # use `bundle install --standalone' to get this...
  require_relative '../vendor/bundler/setup'
rescue LoadError
  # fall back to regular bundler if the developer hasn't bundled standalone
  require 'bundler'
  Bundler.setup
end

unless defined?(VCR)
  require 'vcr'
  require 'webmock'
  VCR.configure do |c|
    c.cassette_library_dir = 'spec/cassettes'
    c.hook_into :webmock
    c.configure_rspec_metadata!
  end
end

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
  c.run_all_when_everything_filtered = true
  c.filter_run_including focus: true

  c.mock_with :rspec
end
