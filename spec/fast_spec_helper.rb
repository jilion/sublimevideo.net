begin
  # use `bundle install --standalone' to get this...
  require_relative '../vendor/bundler/setup'
rescue LoadError
  # fall back to regular bundler if the developer hasn't bundled standalone
  require 'bundler'
  Bundler.setup
end

require_relative 'config/rspec'

unless defined?(Rails)
  module Rails
    def self.root; Pathname.new(File.expand_path('')); end
    def self.env; 'test'; end
  end
end
