require 'capybara/rspec'
require 'capybara/rails'
require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist
Capybara.server_port = 2999

Capybara.configure do |config|
  config.match = :prefer_exact
  config.ignore_hidden_elements = false
end

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
