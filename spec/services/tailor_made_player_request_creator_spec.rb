require 'fast_spec_helper'
require 'active_support/core_ext'

require 'services/tailor_made_player_request_creator'

describe TailorMadePlayerRequestCreator do
  let(:tailor_made_player_request) { build(:tailor_made_player_request) }
  let(:service) { described_class.new(tailor_made_player_request) }

  describe '#create' do
    it 'works' do
      expect { service.create }.to be_true
    end
  end
end
