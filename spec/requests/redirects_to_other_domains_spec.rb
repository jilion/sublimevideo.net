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
      response.location.should eq "https://my.sublimevideo.dev/#{path}"
    end
  end

  %w[stats stats-demo demos/stats].each do |path|
    it "/#{path} redirects to MySV /stats-demo" do
      get "/#{path}"
      response.status.should eq 301
      response.location.should eq "https://my.sublimevideo.dev/stats-demo"
    end
  end

  %w[signup sign_up register].each do |path|
    it "/#{path} redirects to MySV /signup" do
      get "/#{path}"
      response.status.should eq 301
      response.location.should eq "https://my.sublimevideo.dev/signup"
    end
  end

  %w[login log_in sign_in signin].each do |path|
    it "/#{path} redirects to MySV /login" do
      get "/#{path}"
      response.status.should eq 301
      response.location.should eq "https://my.sublimevideo.dev/login"
    end
  end
end
