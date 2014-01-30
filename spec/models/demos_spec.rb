require 'fast_spec_helper'

require 'models/demos'

describe Demos do

  describe '.filename_for_path' do
    before do
      described_class.should_receive(:filenames_for).with('lightbox') { %w[1-custom-overlay-opacity 2-close-button-at-top-right] }
    end

    it 'returns the real file name for a given path' do
      described_class.filename_for_path('lightbox', 'custom-overlay-opacity').should eq '1-custom-overlay-opacity'
    end
  end

  describe '.path_from_filename' do
    it 'returns the real file name without the ordering prefix' do
      described_class.path_from_filename('1-custom-overlay-opacity').should eq 'custom-overlay-opacity'
    end
  end

end
