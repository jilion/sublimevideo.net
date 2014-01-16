# coding: utf-8
require 'spec_helper'

feature 'Demos redirects' do

  %w[demo demos].each do |demo_path|
    scenario "/#{demo_path} redirects to first available demo" do
      visit "/#{demo_path}"

      current_url.should eq 'http://sublimevideo.dev/demos/player-designs/classic'
    end
  end

  context 'feature has only one demo' do
    scenario '/demos/:feature redirects to this feature first demo' do
      visit '/demos/youtube'

      current_url.should eq 'http://sublimevideo.dev/demos/youtube/classic-design'
    end
  end

  context 'feature has several demos' do
    scenario '/demos/:feature redirects to this feature first demo' do
      visit '/demos/responsive-layout/fit-resizing'

      current_url.should eq 'http://sublimevideo.dev/demos/responsive-layout/fit-resizing'
    end
  end

end
