# coding: utf-8
require 'spec_helper'

feature "Com Pages" do

  describe "menu", :vcr do
    scenario 'links are clickable and routable' do
      visit '/'

      within '#menu' do
        current_url.should eq "http://sublimevideo.dev/"

        click_link 'Horizon Framework'
        current_url.should eq "http://sublimevideo.dev/horizon-framework"

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

  describe "footer", :vcr do
    scenario 'links are clickable and routable' do
      visit '/'

      within 'footer' do
        # Product
        click_link 'Horizon Framework'
        current_url.should eq "http://sublimevideo.dev/horizon-framework"

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

  describe "home page", :vcr do
    scenario 'Get It Know link is reachable and show signup popup' do
      visit '/'

      click_link 'Get It Now'

      current_url.should eq "http://sublimevideo.dev/?p=signup"
    end
  end

  describe "redirects", :vcr do
    scenario '/why redirects to /horizon-framework' do
      visit '/why'
      current_url.should eq "http://sublimevideo.dev/horizon-framework"
    end

    scenario '/demo redirects to /modular-player' do
      visit '/demo'
      current_url.should eq "http://sublimevideo.dev/modular-player"
    end

    scenario '/features redirects to /modular-player' do
      visit '/features'
      current_url.should eq "http://sublimevideo.dev/modular-player"
    end

    scenario '/plans redirects to /pricing' do
      visit '/plans'
      current_url.should eq "http://sublimevideo.dev/pricing"
    end

    scenario '/customer-showcase redirects to /testimonials' do
      visit '/customer-showcase'
      current_url.should eq "http://sublimevideo.dev/testimonials"
    end

    %w[signup sign_up register].each do |path|
      scenario "/#{path} redirects to /?p=signup" do
        visit "/#{path}"
        current_url.should eq "http://sublimevideo.dev/?p=signup"
      end
    end

    %w[login log_in sign_in signin].each do |path|
      scenario "/#{path} redirects to /?p=login" do
        visit "/#{path}"
        current_url.should eq "http://sublimevideo.dev/?p=login"
      end
    end
  end

end
