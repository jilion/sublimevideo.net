# coding: utf-8
require 'spec_helper'

feature 'Header navigation links' do
  scenario 'links are clickable and routable' do
    visit '/'

    within 'header' do
      current_url.should eq "http://sublimevideo.dev/"

      click_link 'Features'
      current_url.should eq "http://sublimevideo.dev/features"

      click_link 'Demos'
      current_url.should eq "http://sublimevideo.dev/demos/player-designs/classic"

      click_link 'Documentation'
      current_url.should eq "http://docs.sublimevideo.dev/"
      visit 'http://sublimevideo.dev/' # go back to root

      # forum...

      click_link 'Support'
      current_url.should eq "http://sublimevideo.dev/help"

      # signup & login...
    end
  end
end

feature 'Footer navigation links' do
  scenario 'links are clickable and routable' do
    visit '/'

    within 'footer' do
      # Product
      click_link 'Features'
      current_url.should eq "http://sublimevideo.dev/features"

      click_link 'Testimonials'
      current_url.should eq "http://sublimevideo.dev/testimonials"

      click_link 'Technology'
      current_url.should eq "http://sublimevideo.dev/framework"

      # Support
      click_link 'Documentation'
      current_url.should eq "http://docs.sublimevideo.dev/"
      visit 'http://sublimevideo.dev/' # go back to root

      # player releases...

      # Company
      click_link 'About'
      current_url.should eq "http://sublimevideo.dev/about"

      # blog...

      click_link 'News'
      current_url.should eq "http://sublimevideo.dev/news"

      click_link 'Contact'
      current_url.should eq "http://sublimevideo.dev/contact"

      # jobs...
    end
  end
end
