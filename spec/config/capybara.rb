require 'capybara/rspec'
require 'capybara/rails'

RSpec.configure do |config|
  config.before(type: 'request') do
    host = 'sublimevideo.dev'
    host! host
    Capybara.app_host = "http://#{host}"
  end
  config.before(type: 'feature') do
    Capybara.app_host = 'http://sublimevideo.dev'
  end
end

