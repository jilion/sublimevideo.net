require "spec_helper"

require 'carrierwave/test/matchers'

describe TailorMadePlayerRequestDocumentUploader do
  include CarrierWave::Test::Matchers

  let(:tailor_made_player_request) { build(:tailor_made_player_request) }

  before do
    @uploader = described_class.new(tailor_made_player_request, :document)
    @uploader.store!(File.open(fixture_file('image.jpg')))
  end

  after do
    @uploader.remove!
  end

  it 'has the token in its url' do
    tailor_made_player_request.token.should =~ /[a-z0-9]{8}/i
    @uploader.url.should eq "/uploads/tailor_made_player_requests/#{tailor_made_player_request.token}.jpg"
  end
end
