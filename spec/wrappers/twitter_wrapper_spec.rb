require 'fast_spec_helper'
require 'config/vcr'
require 'active_support/core_ext'

require 'dotenv'
Dotenv.load

require 'wrappers/twitter_wrapper'

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
