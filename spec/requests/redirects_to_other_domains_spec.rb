require 'spec_helper'

describe 'Redirects to other domains' do
  %w[javascript-api releases].each do |path|
    it "/#{path} redirects to DoSV /#{path}" do
      get "/#{path}"
      response.status.should eq 301
      response.location.should eq "http://docs.sublimevideo.dev/#{path}"
    end
  end

  %w[privacy terms sites account].each do |path|
    it "/#{path} redirects to MySV /#{path}" do
      get "/#{path}"
      response.status.should eq 301
      response.location.should eq "http://my.sublimevideo.dev/#{path}"
    end
  end

  %w[stats stats-demo demos/stats].each do |path|
    it "/#{path} redirects to MySV /stats-demo" do
      get "/#{path}"
      response.status.should eq 301
      response.location.should eq "http://my.sublimevideo.dev/stats-demo"
    end
  end
end
