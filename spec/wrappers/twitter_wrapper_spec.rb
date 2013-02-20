require 'fast_spec_helper'
require 'configurator'
require 'twitter'
require 'rescue_me'
require 'config/vcr'

require 'wrappers/twitter_wrapper'

describe TwitterWrapper do

  describe "method_missing" do
    it "delegates to Twitter if possible" do
      Twitter.should_receive(:favorites)
      TwitterWrapper.favorites
    end
  end

  describe "pretty_remote_favorites", :vcr do
    subject { TwitterWrapper.pretty_remote_favorites(
        user_doublon: false,
        count: 3,
        random: true,
        since_date: Time.utc(2011,3,29),
        include_entities: true
    )}

    it "returns 3 tweets" do
      subject.should have(3).tweets
    end
  end
end
