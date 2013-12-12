require 'spec_helper'

describe 'Routes safety' do
  describe 'root' do
    it 'accepts GET requests' do
      get '/'
      response.status.should eq 200
    end

    it 'rejects POST requests' do
      expect { post '/' }.to raise_error(ActionController::RoutingError)
    end
  end
end
