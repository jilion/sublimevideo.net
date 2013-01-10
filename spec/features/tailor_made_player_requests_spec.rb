# coding: utf-8
require 'spec_helper'

feature "TailorMadePlayerRequest", :vcr do

  describe "creation" do
    scenario 'links are clickable and routable' do
      visit '/'
      within '#menu' do
        click_link 'Tailor-Made Players'
      end
      first(:link, 'Need a tailor-made player? Contact us').click

      fill_in 'Your name', with: 'John Doe'
      fill_in 'Email address', with: 'john@doe.com'
      fill_in 'Job title', with: 'Mr. Dev'
      fill_in 'Company', with: 'John Doe SA'
      fill_in 'Website URL', with: 'john_doe.com'
      select 'Switzerland', from: 'Country'
      choose 'I am an agency and I would like to join the partner program to design and sell tailor-made players to my customers.'
      fill_in 'How can we help you?', with: 'I want a gorgeous tailor-made player!'

      click_on 'Submit'

      page.should have_content 'Thank you!'
      page.should have_content 'We have received your contact request. We will get back to you as soon as possible.'

      Sidekiq::Worker.drain_all
      TailorMadePlayerRequest.first.highrise_kase_id.should be_present
    end
  end

end
