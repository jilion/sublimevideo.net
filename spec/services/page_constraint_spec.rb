require 'fast_spec_helper'
require 'active_support/core_ext'

require 'services/page_constraint'

describe PageConstraint do
  class PagesConstraint < PageConstraint; end

  context "request with blog page param" do
    let(:request) { double('request', params: { 'page' => 'blog' }) }
    it { expect(PagesConstraint.matches?(request)).to be_true }
  end

  context "request with modular-player page param" do
    let(:request) { double('request', params: { 'page' => 'modular-player' }) }
    it { expect(PagesConstraint.matches?(request)).to be_true }
  end

  context "request with ** page param" do
    let(:request) { double('request', params: { 'page' => '**' }) }
    it { expect(PagesConstraint.matches?(request)).to be_false }
  end

  context "request with invalid param" do
    let(:request) { double('request') }
    before { request.stub(:params).and_raise(ArgumentError) }
    it { expect(PagesConstraint.matches?(request)).to be_false }
  end
end
