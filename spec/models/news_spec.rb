# coding: utf-8
# require 'spec_helper'
require 'fast_spec_helper'
require 'active_support/deprecation'
require 'active_support/core_ext'
require 'atom'
require File.expand_path('app/models/news')

describe News do

  describe ".get_latest_sublimevideo_news", :vcr do

    it "returns latest news" do
      News.get_latest_sublimevideo_news(3).should have(3).news
    end

    describe "entry" do
      subject { News.get_latest_sublimevideo_news(3).first }

      its(:title)      { should eq "A Closer Look at SublimeVideo’s Universal Real-Time Statistics" }
      its(:url)        { should eq "http://blog.jilion.com/2012/02/15/a-closer-look-at-sublimevideo-s-universal-real-time-statistics" }
      its(:categories) { should eq ['SublimeVideo'] }
      its(:date)       { should eq Time.utc(2012,2,14,23) }
    end

  end

end
