# coding: utf-8
require 'spec_helper'

describe TweetsHelper do

  describe "#clean_tweet_text" do
    context "with entities", :vcr do
      subject { Twitter.status(14786759290) }

      it "removes urls" do
        helper.clean_tweet_text(subject).should eq "Help with the oil spill using @appcelerator #titanium and the awesome @intridea Oil Reporter API ."
      end
    end

    context "with cc (53152800456179712)", :vcr do
      subject { Twitter.status(53152800456179712, include_entities: true) }

      it "removes cc" do
        helper.clean_tweet_text(subject).should eq "I want to be like @Jilion when I grow up. Their video player hosting service looks amazing. Kudos!"
      end
    end
  end

end
