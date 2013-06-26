require 'fast_spec_helper'

require 'services/demo_page_constraint'

describe DemoPageConstraint do

  class DemosConstraint < described_class
  end

  describe '.matches?' do
    let(:request_simple_path) { stub(path: '/demos/youtube/classic-player')}
    let(:request_numbered_path) { stub(path: '/demos/lightbox/1-custom-overlay-opacity')}

    it 'returns true for simple path' do
      DemosConstraint.matches?(request_simple_path).should be_true
    end

    it 'returns true for numbered path' do
      DemosConstraint.matches?(request_numbered_path).should be_true
    end
  end

end
