# coding: utf-8
require 'spec_helper'

feature 'Legacy redirects' do
  %w[why horizon-video horizon-framework].each do |page|
    scenario "/#{page} redirects to /framework" do
      visit "/#{page}"
      current_url.should eq "http://sublimevideo.dev/framework"
    end
  end

  scenario '/plans redirects to /pricing' do
    visit '/plans'
    current_url.should eq 'http://sublimevideo.dev/pricing'
  end

  scenario '/customer-showcase redirects to /testimonials' do
    visit '/customer-showcase'
    current_url.should eq "http://sublimevideo.dev/testimonials"
  end
end
