# coding: utf-8
require 'spec_helper'

feature "Com Pages" do

  context "unlogged visitor" do

    describe "menu", :vcr do
      scenario 'links are clickable and routable' do
        visit '/'

        within '#menu' do
          current_url.should eq "http://sublimevideo.dev/"

          click_link 'features'
          current_url.should eq "http://sublimevideo.dev/features"

          click_link 'plans'
          current_url.should eq "http://sublimevideo.dev/plans"

          click_link 'demo'
          current_url.should eq "http://sublimevideo.dev/demo"

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
          click_link 'Home'
          current_url.should eq "http://sublimevideo.dev/"

          click_link 'Features'
          current_url.should eq "http://sublimevideo.dev/features"

          click_link 'Demo'
          current_url.should eq "http://sublimevideo.dev/demo"

          click_link 'Plans & Pricing'
          current_url.should eq "http://sublimevideo.dev/plans"

          click_link 'Customer Showcase'
          current_url.should eq "http://sublimevideo.dev/customer-showcase"

          click_link 'Help'
          current_url.should eq "http://sublimevideo.dev/help"

          click_link 'Documentation'
          current_url.should eq "http://docs.sublimevideo.dev/"

          # click_link 'Player Releases'
          # current_url.should eq "http://docs.sublimevideo.dev/releases"

          # click_link 'Blog'
          # current_url.should eq "http://sublimevideo.dev/blog"

          click_link 'Contact'
          current_url.should eq "http://sublimevideo.dev/contact"

          click_link 'About'
          current_url.should eq "http://sublimevideo.dev/about"

          # click_link 'Terms & Conditions'
          # current_url.should eq "http://my.sublimevideo.dev/terms"
          #
          # click_link 'Privacy Policy'
          # current_url.should eq "http://my.sublimevideo.dev/privacy"
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
  end

end
