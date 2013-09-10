# coding: utf-8
require 'spec_helper'

feature 'Header navigation links' do
  scenario 'links are clickable and routable' do
    visit '/'
    current_url.should eq "http://sublimevideo.dev/"

    within '#menu' do
      click_link 'Framework'
      current_url.should eq "http://sublimevideo.dev/framework"

      click_link 'Modular Player'
      current_url.should eq "http://sublimevideo.dev/modular-player"

      click_link 'Tailor-Made Players'
      current_url.should eq "http://sublimevideo.dev/tailor-made-players"

      click_link 'pricing'
      current_url.should eq "http://sublimevideo.dev/pricing"

      click_link 'news'
      current_url.should eq "http://sublimevideo.dev/news"

      click_link 'help'
      current_url.should eq "http://sublimevideo.dev/help"

      click_link 'login'
      current_url.should eq "http://sublimevideo.dev/?p=login"

      click_link 'sign up'
      current_url.should eq "http://sublimevideo.dev/?p=signup"

      click_link 'login'
      current_url.should eq "http://sublimevideo.dev/?p=login"
    end
  end
end

feature 'Footer navigation links' do
  scenario 'links are clickable and routable' do
    visit '/'

    within 'footer' do
        # Product
        click_link 'Framework'
        current_url.should eq "http://sublimevideo.dev/framework"

        click_link 'Modular Player'
        current_url.should eq "http://sublimevideo.dev/modular-player"

        click_link 'Tailor-Made Players'
        current_url.should eq "http://sublimevideo.dev/tailor-made-players"

        click_link 'Testimonials'
        current_url.should eq "http://sublimevideo.dev/testimonials"

        # Support
        click_link 'Help'
        current_url.should eq "http://sublimevideo.dev/help"

        click_link 'Documentation'
        current_url.should eq "http://docs.sublimevideo.dev/"

        # forum...
        # player releases...

        # Company
        click_link 'About'
        current_url.should eq "http://sublimevideo.dev/about"

        click_link 'News'
        current_url.should eq "http://sublimevideo.dev/news"

        # blog...

        click_link 'Contact'
        current_url.should eq "http://sublimevideo.dev/contact"
    end
  end
end

feature 'Home navigation links' do
  scenario 'Get It Know link is reachable and show signup popup' do
    visit '/'
    current_url.should eq "http://sublimevideo.dev/"

    click_link 'Get It Now'

    current_url.should eq "http://sublimevideo.dev/?p=signup"
  end
end
