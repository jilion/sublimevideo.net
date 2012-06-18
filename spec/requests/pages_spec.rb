# coding: utf-8
require 'spec_helper'

feature "Com Pages" do

  describe "menu", :vcr do
    scenario 'links are clickable and routable' do
      visit '/'

      within '#menu' do
        current_url.should eq "http://sublimevideo.dev/"

        click_link 'features'
        current_url.should eq "http://sublimevideo.dev/features"

        click_link 'plans'
        current_url.should eq "http://sublimevideo.dev/plans"

        click_link 'showcase'
        current_url.should eq "http://sublimevideo.dev/customer-showcase"

        click_link 'help'
        current_url.should eq "http://sublimevideo.dev/help"

        # click_link 'Blog'
        # current_url.should eq "http://sublimevideo.dev/blog"

        click_link 'login'
        current_url.should eq "http://sublimevideo.dev/?p=login"

        click_link 'sign up'
        current_url.should eq "http://sublimevideo.dev/?p=signup"
      end
    end
  end

  describe "footer", :vcr do
    scenario 'links are clickable and routable' do
      visit '/'

      within 'footer' do
        # Product
        click_link 'Why SublimeVideo?'
        current_url.should eq "http://sublimevideo.dev/why"

        click_link 'Features'
        current_url.should eq "http://sublimevideo.dev/features"

        click_link 'Plans & Pricing'
        current_url.should eq "http://sublimevideo.dev/plans"

        click_link 'Customer Showcase'
        current_url.should eq "http://sublimevideo.dev/customer-showcase"

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

  describe "home page" do
    scenario 'Get It Know link is reachable and show signup popup' do
      visit '/'

      click_link 'Get It Now'

      current_url.should eq "http://sublimevideo.dev/?p=signup"
    end
  end

  describe "redirects" do
    scenario '/demo redirects to /features' do
      visit '/demo'
      current_url.should eq "http://sublimevideo.dev/features"
    end
  end

end
