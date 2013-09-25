require 'fast_spec_helper'
require 'config/vcr'

require 'wrappers/twitter_wrapper'

Twitter.configure do |config|
  config.consumer_key       = ENV['TWITTER_CONSUMER_KEY']
  config.consumer_secret    = ENV['TWITTER_CONSUMER_SECRET']
  config.oauth_token        = ENV['TWITTER_OAUTH_TOKEN']
  config.oauth_token_secret = ENV['TWITTER_OAUTH_TOKEN_SECRET']
end

describe TwitterWrapper do

  describe ".pretty_favorites", :vcr do
    let(:tweets) do
      TwitterWrapper.pretty_favorites(count: 3, since_date: Time.utc(2011, 3, 29))
    end

    it "returns 3 tweets" do
      tweets.should have(3).tweets
    end
  end

end
