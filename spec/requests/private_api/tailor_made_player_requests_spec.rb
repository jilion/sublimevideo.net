require 'spec_helper'

describe 'Private API TailorMadePlayerRequest requests' do
  let!(:tailor_made_player_request1) { create(:tailor_made_player_request) }
  let!(:tailor_made_player_request2) { create(:tailor_made_player_request, topic: 'standalone') }

  before do
    set_api_credentials
    @env['HTTP_HOST'] = 'my.sublimevideo.dev'
  end

  describe 'index' do
    let(:url) { "private_api/tailor_made_player_requests.json" }

    it_behaves_like 'valid caching headers', cache_validation: false

    it 'supports :with_topic and created_before scope' do
      get url, { with_topic: 'agency', created_before: 1.day.from_now }, @env
      body = MultiJson.load(response.body)
      body.should have(1).tailor_made_player_request
      body[0]['topic'].should eq 'agency'

      response.status.should eq 200
    end
  end
end
