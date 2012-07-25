require "spec_helper"

describe Rack::Redirect do
  include Rack::Test::Methods

  let(:mock_app) do
    main_app = lambda { |env|
      request = Rack::Request.new(env)
      headers = { 'Content-Type' => "text/html" }
      [200, headers, ['Hello world!']]
    }

    builder = Rack::Builder.new
    builder.use Rack::Redirect
    builder.run main_app
    @app = builder.to_app
  end

  def app
    mock_app
  end

  describe 'redirects to docs' do
    %w[javascript-api releases].each do |path|
      it "/#{path} redirects to http://docs.sublimevideo.dev/#{path}" do
        get "/#{path}"

        last_response.location.should eq "http://docs.example.org/#{path}"
        last_response.status.should eq 301
      end
    end
  end

  describe 'redirects to my' do
    %w[privacy terms sites account].each do |path|
      it "/#{path} redirects to https://my.sublimevideo.dev/#{path}" do
        get "/#{path}"

        last_response.location.should eq "https://my.example.org/#{path}"
        last_response.status.should eq 301
      end
    end
  end

end
