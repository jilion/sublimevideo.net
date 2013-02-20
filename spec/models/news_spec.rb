# coding: utf-8
require 'fast_spec_helper'
require 'active_support/core_ext'
require 'config/vcr'
require 'atom'

require 'models/news'

describe News do

  describe ".get_latest_sublimevideo_news", :vcr do

    it "returns latest news" do
      News.get_latest_sublimevideo_news(3).should have(3).news
    end

    describe "entry" do
      subject { News.get_latest_sublimevideo_news(3).first }

      its(:title)      { should eq "Introducing SublimeVideo Horizon Framework" }
      its(:url)        { should eq "http://blog.jilion.com/2012/12/14/introducing-sublimevideo-horizon-framework" }
      its(:categories) { should eq ['SublimeVideo'] }
      its(:date)       { should eq Time.utc(2012,12,14) }
    end

  end

end
