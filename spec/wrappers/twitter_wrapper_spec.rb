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

  describe "method_missing" do
    it "delegates to Twitter if possible" do
      Twitter.should_receive(:favorites)
      TwitterWrapper.send(:_favorites, 'sublimevideo', {})
    end
  end

  describe "pretty_favorites", :vcr do
    let(:tweets) do
      TwitterWrapper.pretty_favorites(user_doublon: false,
                                      count: 3,
                                      random: true,
                                      since_date: Time.utc(2011, 3, 29),
                                      include_entities: true)
    end

    it "returns 3 tweets" do
      tweets.should have(3).tweets
    end
  end
end
