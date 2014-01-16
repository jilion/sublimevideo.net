require 'fast_spec_helper'

require 'services/demo_page_constraint'

describe DemoPageConstraint do

  class DemosConstraint < described_class
  end

  describe '.matches?' do
    let(:request_simple_path) { double(path: '/demos/embed/auto-embed')}
    let(:request_numbered_path) { double(path: '/demos/lightbox/custom-overlay-opacity')}
    let(:request_path_without_demo_page) { double(path: '/demos/lightbox')}

    it 'returns true for path without demo page' do
      DemosConstraint.matches?(request_path_without_demo_page).should be_true
    end

    it 'returns true for simple path' do
      DemosConstraint.matches?(request_simple_path).should be_true
    end

    it 'returns true for numbered path' do
      DemosConstraint.matches?(request_numbered_path).should be_true
    end
  end

end
